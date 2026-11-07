import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../services/notification_service.dart';

final databaseProvider = Provider<DontForgetDatabase>((ref) {
  return DontForgetDatabase();
});

final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final notificationService = NotificationService();
  return AlarmRepository(db, notificationService);
});

class AlarmRepository {
  final DontForgetDatabase _db;
  final NotificationService _notificationService;

  AlarmRepository(this._db, this._notificationService);

  Stream<List<Alarm>> watchAllAlarms() {
    return _db.select(_db.alarms).watch();
  }

  Future<void> addAlarm(AlarmsCompanion alarmCompanion) async {
    // 1. Save to SQLite
    final id = await _db.insertAlarm(alarmCompanion);
    
    // 2. Fetch the created record to get the full Alarm object (with default values applied)
    final createdAlarm = await (_db.select(_db.alarms)..where((a) => a.id.equals(id))).getSingle();
    
    // 3. Schedule via iOS AlarmKit
    await _notificationService.scheduleAlarm(createdAlarm);
  }

  Future<void> updateAlarm(Alarm alarm) async {
    await _db.updateAlarm(alarm);
    await _notificationService.scheduleAlarm(alarm);
  }

  Future<void> deleteAlarm(int id) async {
    await _db.deleteAlarm(id);
    await _notificationService.cancelAlarm(id);
  }

  Future<void> toggleAlarmState(Alarm alarm, bool isEnabled) async {
    final updatedAlarm = alarm.copyWith(isEnabled: isEnabled);
    await _db.updateAlarm(updatedAlarm);
    await _notificationService.scheduleAlarm(updatedAlarm);
  }
}