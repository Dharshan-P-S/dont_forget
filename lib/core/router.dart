import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/calendar/calendar_screen.dart';
import '../features/upcoming/upcoming_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/navigation/main_scaffold.dart';

final goRouter = GoRouter(
  initialLocation: '/calendar',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/calendar',
          builder: (context, state) => const CalendarScreen(),
        ),
        GoRoute(
          path: '/upcoming',
          builder: (context, state) => const UpcomingScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/create',
          parentNavigatorKey:
              goRouter.routerDelegate.navigatorKey,
          pageBuilder: (context, state) {
            final date = state.extra as DateTime?;
            return MaterialPage(
              fullscreenDialog: true,
              child: CreateAlarmScreen(initialDate: date),
            );
          },
        ),
      ],
    ),
  ],
);
