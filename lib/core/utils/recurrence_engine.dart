import 'package:dont_forget/core/database/database.dart';

class RecurrenceEngine {
  /// Calculates the next [count] occurrences for a given alarm configuration.
  static List<DateTime> generateOccurrences({
    required DateTime originalDate,
    required int hour,
    required int minute,
    required RecurrenceType type,
    List<int>? customWeekdays,
    int count = 10,
  }) {
    List<DateTime> occurrences = [];
    
    // Start with the exact first scheduled date and time
    DateTime current = DateTime(
      originalDate.year,
      originalDate.month,
      originalDate.day,
      hour,
      minute,
    );

    // If the first occurrence is in the past, we need to advance it to the next valid date
    if (current.isBefore(DateTime.now()) && type != RecurrenceType.never) {
      current = _calculateNext(current, type, originalDate.day, customWeekdays);
    }

    for (int i = 0; i < count; i++) {
      occurrences.add(current);
      if (type == RecurrenceType.never) break;
      
      current = _calculateNext(current, type, originalDate.day, customWeekdays);
    }

    return occurrences;
  }

  static DateTime _calculateNext(DateTime current, RecurrenceType type, int originalDay, List<int>? weekdays) {
    switch (type) {
      case RecurrenceType.never:
        return current;
        
      case RecurrenceType.daily:
        return current.add(const Duration(days: 1));
        
      case RecurrenceType.weekly:
        return current.add(const Duration(days: 7));
        
      case RecurrenceType.monthly:
        return _addMonths(current, 1, originalDay);
        
      case RecurrenceType.yearly:
        return _addYears(current, 1, originalDay);
        
      case RecurrenceType.custom:
        return _nextCustomWeekday(current, weekdays ?? []);
    }
  }

  /// Safely adds months while clamping to the end of the month if necessary.
  /// Example: Jan 31 + 1 month -> Feb 28 (or 29 in leap year).
  static DateTime _addMonths(DateTime date, int monthsToAdd, int originalDay) {
    int targetYear = date.year;
    int targetMonth = date.month + monthsToAdd;
    
    // Handle year overflow
    while (targetMonth > 12) {
      targetMonth -= 12;
      targetYear++;
    }

    int daysInTargetMonth = DateTime(targetYear, targetMonth + 1, 0).day;
    int clampedDay = originalDay > daysInTargetMonth ? daysInTargetMonth : originalDay;

    return DateTime(targetYear, targetMonth, clampedDay, date.hour, date.minute);
  }

  /// Safely adds years, handling Leap Year (Feb 29 -> Feb 28 on non-leap years)
  static DateTime _addYears(DateTime date, int yearsToAdd, int originalDay) {
    int targetYear = date.year + yearsToAdd;
    int daysInTargetMonth = DateTime(targetYear, date.month + 1, 0).day;
    int clampedDay = originalDay > daysInTargetMonth ? daysInTargetMonth : originalDay;
    
    return DateTime(targetYear, date.month, clampedDay, date.hour, date.minute);
  }

  /// Finds the next date that matches one of the selected custom weekdays.
  /// Dart's DateTime.weekday: 1 = Monday, 7 = Sunday.
  static DateTime _nextCustomWeekday(DateTime current, List<int> validWeekdays) {
    if (validWeekdays.isEmpty) return current.add(const Duration(days: 1));
    
    DateTime next = current.add(const Duration(days: 1));
    // Keep advancing until the weekday matches one of our selections
    while (!validWeekdays.contains(next.weekday)) {
      next = next.add(const Duration(days: 1));
    }
    return next;
  }

  /// Calculates all trigger timestamps including pre-alert offsets.
  /// Used by the Notification Service to schedule native iOS notifications.
  static List<DateTime> calculateAllTriggers(List<DateTime> occurrences, List<int> offsetsInMinutes) {
    List<DateTime> triggers = [];
    
    for (var occurrence in occurrences) {
      if (offsetsInMinutes.isEmpty) {
        triggers.add(occurrence);
      } else {
        for (var offset in offsetsInMinutes) {
          triggers.add(occurrence.subtract(Duration(minutes: offset)));
        }
      }
    }
    
    // Filter out triggers that are already in the past
    return triggers.where((t) => t.isAfter(DateTime.now())).toList();
  }
}