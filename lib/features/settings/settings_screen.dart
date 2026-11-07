import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import 'settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildSectionHeader(context, 'Appearance'),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text('Theme'),
                  trailing: DropdownButton<ThemeMode>(
                    value: settings.themeMode,
                    dropdownColor: DontForgetTheme.surfaceDark,
                    underline: const SizedBox(),
                    items: ThemeMode.values.map((mode) {
                      return DropdownMenuItem(
                        value: mode,
                        child: Text(mode.name.toUpperCase(), style: Theme.of(context).textTheme.bodyLarge),
                      );
                    }).toList(),
                    onChanged: (mode) {
                      if (mode != null) ref.read(settingsProvider.notifier).setThemeMode(mode);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader(context, 'Date & Time'),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Use 24-hour format'),
                  activeColor: DontForgetTheme.accentGold,
                  value: settings.use24HourFormat,
                  onChanged: (val) => ref.read(settingsProvider.notifier).setUse24HourFormat(val),
                ),
                const Divider(height: 1, indent: 16, color: DontForgetTheme.borderSubtle),
                ListTile(
                  title: const Text('Default Snooze Duration'),
                  trailing: Text('${settings.defaultSnoozeMinutes} min', style: const TextStyle(color: DontForgetTheme.accentGold)),
                  onTap: () {
                    // Phase 8: Add snooze duration picker modal
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _buildSectionHeader(context, 'About'),
          Card(
            child: ListTile(
              title: const Text('DontForget'),
              subtitle: const Text('Some things are too important to forget.\nVersion 1.0.0'),
              isThreeLine: true,
              trailing: const Icon(Icons.info_outline, color: DontForgetTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: DontForgetTheme.accentGold,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}