import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../database/database.dart';
import '../utils/recurrence_engine.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize timezone data
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.local);

    // iOS Initialization Settings
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  }

  void _onSelectNotification(NotificationResponse response) {
    // Handle notification tap (e.g., navigate to specific alarm details in Phase 7)
    print('Notification tapped: ${response.payload}');
  }

  /// Schedules native iOS notifications for an alarm's calculated future occurrences.
  Future<void> scheduleAlarm(Alarm alarm) async {
    // 1. Cancel existing notifications for this alarm if updating
    await cancelAlarm(alarm.id);

    if (!alarm.isEnabled) return;

    // 2. Generate the next 3 occurrences to respect Apple's 64 limit
    final occurrences = RecurrenceEngine.generateOccurrences(
      originalDate: alarm.originalDate,
      hour: alarm.scheduledHour,
      minute: alarm.scheduledMinute,
      type: alarm.recurrenceType,
      customWeekdays: alarm.customWeekdays,
      count: 3, 
    );

    // 3. Map occurrences against the pre-alert offsets
    final offsets = alarm.preAlertOffsets.isEmpty ? [0] : alarm.preAlertOffsets;
    
    int iterationIndex = 0;
    
    for (int i = 0; i < occurrences.length; i++) {
      for (int j = 0; j < offsets.length; j++) {
        final triggerTime = occurrences[i].subtract(Duration(minutes: offsets[j]));
        
        // Skip if this specific trigger time is already in the past
        if (triggerTime.isBefore(DateTime.now())) continue;

        // Create a unique deterministic ID for this specific trigger
        // Format: [AlarmID][OccurrenceIndex][OffsetIndex] (e.g., Alarm 15 -> 1500, 1501, 1510)
        final notificationId = (alarm.id * 1000) + (i * 10) + j;
        
        String bodyText = 'Scheduled for ${alarm.scheduledHour}:${alarm.scheduledMinute.toString().padLeft(2, '0')}';
        if (offsets[j] > 0) {
          bodyText = 'Upcoming: ${alarm.title} in ${offsets[j] >= 60 ? '${offsets[j] ~/ 60} hour(s)' : '${offsets[j]} minutes'}';
        }

        await _flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          alarm.title,
          bodyText,
          tz.TZDateTime.from(triggerTime, tz.local),
          const NotificationDetails(
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
              interruptionLevel: InterruptionLevel.timeSensitive, // Crucial for reliable iOS delivery
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // Required param, ignored on iOS
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
          payload: alarm.id.toString(),
        );
        
        iterationIndex++;
        // Safety net against iOS limit
        if (iterationIndex >= 20) return; 
      }
    }
  }

  /// Cancels all scheduled triggers associated with a specific alarm ID.
  Future<void> cancelAlarm(int alarmId) async {
    // Because we use a deterministic formula for IDs (alarmId * 1000 + i*10 + j),
    // we cancel a safe range of potential generated IDs for this alarm.
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        final notificationId = (alarmId * 1000) + (i * 10) + j;
        await _flutterLocalNotificationsPlugin.cancel(notificationId);
      }
    }
  }
}