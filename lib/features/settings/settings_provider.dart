import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialized in main.dart');
});

final settingsProvider = ChangeNotifierProvider<SettingsNotifier>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});

class SettingsNotifier extends ChangeNotifier {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs);

  // Theme settings
  ThemeMode get themeMode {
    final themeStr = _prefs.getString('themeMode') ?? ThemeMode.dark.name;
    return ThemeMode.values.firstWhere((e) => e.name == themeStr, orElse: () => ThemeMode.dark);
  }

  void setThemeMode(ThemeMode mode) {
    _prefs.setString('themeMode', mode.name);
    notifyListeners();
  }

  // Time format settings (12h vs 24h)
  bool get use24HourFormat => _prefs.getBool('use24HourFormat') ?? false;

  void setUse24HourFormat(bool use24) {
    _prefs.setBool('use24HourFormat', use24);
    notifyListeners();
  }

  // Default snooze
  int get defaultSnoozeMinutes => _prefs.getInt('defaultSnoozeMinutes') ?? 5;

  void setDefaultSnoozeMinutes(int minutes) {
    _prefs.setInt('defaultSnoozeMinutes', minutes);
    notifyListeners();
  }
}