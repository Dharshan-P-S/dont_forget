import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme.dart';
import 'core/router.dart';
import 'core/services/notification_service.dart';
import 'features/settings/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize iOS Notifications & Timezones
  await NotificationService().init();

  // 2. Load SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const DontForgetApp(),
    ),
  );
}

class DontForgetApp extends ConsumerWidget {
  const DontForgetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(settingsProvider.select((s) => s.themeMode));

    return MaterialApp.router(
      title: 'DontForget',
      debugShowCheckedModeBanner: false,
      theme: DontForgetTheme.lightTheme, // You can define this in theme.dart
      darkTheme: DontForgetTheme.darkTheme, 
      themeMode: themeMode,
      routerConfig: goRouter,
    );
  }
}