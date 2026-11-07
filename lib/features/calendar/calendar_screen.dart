import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<dynamic>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  // Phase 4 will replace this with Drift Database queries
  List<dynamic> _getEventsForDay(DateTime day) {
    return [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DontForget',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2050, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              titleTextStyle: Theme.of(context).textTheme.titleLarge!,
              formatButtonVisible: false,
              leftChevronIcon: const Icon(Icons.chevron_left, color: DontForgetTheme.accentGold),
              rightChevronIcon: const Icon(Icons.chevron_right, color: DontForgetTheme.accentGold),
            ),
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              defaultTextStyle: Theme.of(context).textTheme.bodyLarge!,
              weekendTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: DontForgetTheme.textSecondary),
              selectedDecoration: const BoxDecoration(
                color: DontForgetTheme.accentGold,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(color: DontForgetTheme.backgroundDark, fontWeight: FontWeight.bold),
              todayDecoration: BoxDecoration(
                border: Border.all(color: DontForgetTheme.accentGold, width: 2),
                shape: BoxShape.circle,
              ),
              todayTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: DontForgetTheme.accentGold),
            ),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const Divider(color: DontForgetTheme.borderSubtle, height: 32),
          Expanded(
            child: ValueListenableBuilder<List<dynamic>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm_off, size: 48, color: DontForgetTheme.textSecondary.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        Text(
                          'No alarms for ${DateFormat('MMMM d').format(_selectedDay!)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(); // Will implement Alarm Cards in Phase 3
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger Route to Create Alarm Screen
        },
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}