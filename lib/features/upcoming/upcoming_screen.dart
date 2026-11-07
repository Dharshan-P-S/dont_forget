import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';
import '../../core/repositories/alarm_repository.dart';
import '../../core/database/database.dart';
import '../../core/utils/recurrence_engine.dart';
import '../settings/settings_provider.dart';

class UpcomingScreen extends ConsumerWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmRepo = ref.watch(alarmRepositoryProvider);
    final use24Hour = ref.watch(settingsProvider).use24HourFormat;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upcoming',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: StreamBuilder<List<Alarm>>(
        stream: alarmRepo.watchAllAlarms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: DontForgetTheme.accentGold));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyState(context);
          }

          final alarms = snapshot.data!;
          // 1. Calculate next occurrence for each enabled alarm
          final upcomingList = >[];
          final now = DateTime.now();

          for (var alarm in alarms) {
            if (!alarm.isEnabled) continue;
            
            // Generate next few occurrences and pick the first one in the future
            final occurrences = RecurrenceEngine.generateOccurrences(
              originalDate: alarm.originalDate,
              hour: alarm.scheduledHour,
              minute: alarm.scheduledMinute,
              type: alarm.recurrenceType,
              customWeekdays: alarm.customWeekdays,
              count: 5,
            );
            
            final nextOccurrence = occurrences.firstWhere((d) => d.isAfter(now), orElse: () => DateTime.fromMillisecondsSinceEpoch(0));
            
            if (nextOccurrence.year > 2000) {
              upcomingList.add({
                'alarm': alarm,
                'nextDate': nextOccurrence,
              });
            }
          }

          // 2. Sort chronologically
          upcomingList.sort((a, b) => (a['nextDate'] as DateTime).compareTo(b['nextDate'] as DateTime));

          if (upcomingList.isEmpty) return _buildEmptyState(context);

          // 3. Render list
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: upcomingList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = upcomingList[index];
              final alarm = item['alarm'] as Alarm;
              final nextDate = item['nextDate'] as DateTime;
              
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  title: Text(alarm.title, style: Theme.of(context).textTheme.titleLarge),
                  subtitle: Text(
                    DateFormat('EEEE, MMM d').format(nextDate),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatTime(alarm.scheduledHour, alarm.scheduledMinute, use24Hour),
                        style: const TextStyle(color: DontForgetTheme.accentGold, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        alarm.recurrenceType.name.toUpperCase(),
                        style: const TextStyle(color: DontForgetTheme.textSecondary, fontSize: 10, letterSpacing: 1),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Phase 8: Navigate to alarm edit
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available, size: 48, color: DontForgetTheme.textSecondary.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text('No upcoming alarms', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  String _formatTime(int hour, int minute, bool use24) {
    final dt = DateTime(2000, 1, 1, hour, minute);
    return use24 ? DateFormat('HH:mm').format(dt) : DateFormat('h:mm a').format(dt);
  }
}