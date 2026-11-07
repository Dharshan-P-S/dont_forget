import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../core/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/repositories/alarm_repository.dart';
import 'package:drift/drift.dart' as drift;

class CreateAlarmScreen extends StatefulWidget {
  final DateTime? initialDate;
  const CreateAlarmScreen({super.key, this.initialDate});

  @override
  ConsumerState<CreateAlarmScreen> createState() => _CreateAlarmScreenState();
}

class _CreateAlarmScreenState extends ConsumerState<CreateAlarmScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  final RecurrenceType _recurrence = RecurrenceType.never;
  
  // Stores offsets in minutes: e.g., 0 (At time of event), 60 (1 hour before), 1440 (1 day before)
  final List<int> _preAlertOffsets = []; 

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  String _formatOffset(int minutes) {
    if (minutes == 0) return 'At time of event';
    if (minutes == 5) return '5 minutes before';
    if (minutes == 60) return '1 hour before';
    if (minutes == 1440) return '1 day before';
    if (minutes == 2880) return '2 days before';
    return '$minutes minutes before';
  }

  void _showOffsetPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: DontForgetTheme.surfaceDark,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        final options = [0, 5, 60, 1440, 2880];
        return ListView.builder(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            final offset = options[index];
            final isSelected = _preAlertOffsets.contains(offset);
            return ListTile(
              title: Text(_formatOffset(offset), style: Theme.of(context).textTheme.bodyLarge),
              trailing: isSelected ? const Icon(Icons.check, color: DontForgetTheme.accentGold) : null,
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _preAlertOffsets.remove(offset);
                  } else {
                    _preAlertOffsets.add(offset);
                    _preAlertOffsets.sort();
                  }
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _saveAlarm() async {
      if (_formKey.currentState!.validate()) {
        final alarmRepo = ref.read(alarmRepositoryProvider);
        
        final companion = AlarmsCompanion(
          title: drift.Value(_titleController.text.trim()),
          originalDate: drift.Value(_selectedDate),
          scheduledHour: drift.Value(_selectedTime.hour),
          scheduledMinute: drift.Value(_selectedTime.minute),
          recurrenceType: drift.Value(_recurrence),
          preAlertOffsets: drift.Value(_preAlertOffsets),
          // If custom recurrence, you would map custom weekdays here
        );

        await alarmRepo.addAlarm(companion);
        
        if (mounted) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alarm scheduled successfully', style: TextStyle(color: Colors.white)),
              backgroundColor: Color(0xFFE5C158), // accentGold
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: DontForgetTheme.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('New Alarm', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          TextButton(
            onPressed: _saveAlarm,
            child: const Text('Save', style: TextStyle(color: DontForgetTheme.accentGold, fontSize: 16, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Title Input
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: TextFormField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title (e.g., Birthday, Exam)',
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: DontForgetTheme.textSecondary),
                  ),
                  validator: (val) => val == null || val.isEmpty ? 'Please enter a title' : null,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Date & Time Selectors
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Date'),
                    trailing: Text(
                      DateFormat('EEE, MMM d, yyyy').format(_selectedDate),
                      style: const TextStyle(color: DontForgetTheme.accentGold, fontSize: 16),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 1)),
                        lastDate: DateTime(2050),
                      );
                      if (date != null) setState(() => _selectedDate = date);
                    },
                  ),
                  const Divider(height: 1, indent: 16, color: DontForgetTheme.borderSubtle),
                  ListTile(
                    title: const Text('Time'),
                    trailing: Text(
                      _selectedTime.format(context),
                      style: const TextStyle(color: DontForgetTheme.accentGold, fontSize: 16),
                    ),
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: _selectedTime);
                      if (time != null) setState(() => _selectedTime = time);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recurrence & Pre-Alerts
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Repeat'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _recurrence.name.toUpperCase(),
                          style: const TextStyle(color: DontForgetTheme.textSecondary, fontSize: 16),
                        ),
                        const Icon(Icons.chevron_right, color: DontForgetTheme.textSecondary),
                      ],
                    ),
                    onTap: () {
                      // Will launch recurrence selector in Phase 5
                    },
                  ),
                  const Divider(height: 1, indent: 16, color: DontForgetTheme.borderSubtle),
                  ListTile(
                    title: const Text('Alerts'),
                    subtitle: _preAlertOffsets.isEmpty 
                        ? null 
                        : Text(_preAlertOffsets.map(_formatOffset).join('\n')),
                    trailing: const Icon(Icons.chevron_right, color: DontForgetTheme.textSecondary),
                    onTap: _showOffsetPicker,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}