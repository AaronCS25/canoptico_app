import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canoptico_app/features/shared/shared.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Settings", style: textTheme.headlineMedium),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Configure your cat feeder settings",
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),

              // Theme Selector
              Text("Theme", style: textTheme.titleMedium),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ThemeButton(
                    icon: Icons.favorite,
                    label: "Warm",
                    isSelected:
                        context.watch<ThemeCubit>().state.themeMode ==
                        ThemeSetting.warm,
                    onTap: () => context.read<ThemeCubit>().setThemeMode(
                      ThemeSetting.warm,
                    ),
                  ),
                  _ThemeButton(
                    icon: Icons.light_mode,
                    label: "Light",
                    isSelected:
                        context.watch<ThemeCubit>().state.themeMode ==
                        ThemeSetting.light,
                    onTap: () => context.read<ThemeCubit>().setThemeMode(
                      ThemeSetting.light,
                    ),
                  ),
                  _ThemeButton(
                    icon: Icons.dark_mode,
                    label: "Dark",
                    isSelected:
                        context.watch<ThemeCubit>().state.themeMode ==
                        ThemeSetting.dark,
                    onTap: () => context.read<ThemeCubit>().setThemeMode(
                      ThemeSetting.dark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Settings options
              _SettingsButton(
                icon: Icons.settings,
                label: "Device Settings",
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SettingsButton(
                icon: Icons.camera_alt,
                label: "Camera Settings",
                onTap: () {},
              ),
              const SizedBox(height: 12),
              _SettingsButton(
                icon: Icons.wifi,
                label: "Network Settings",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primary : Colors.transparent,
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.onPrimary
                  : colorScheme.onSecondary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SettingsButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        elevation: 0,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
