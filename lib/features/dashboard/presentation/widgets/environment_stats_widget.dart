import 'package:flutter/material.dart';

enum EnvironmentStatsType { humidity, foodLevel }

class EnvironmentStatsWidget extends StatelessWidget {
  final EnvironmentStatsType type;
  final double value;
  final String? customLabel;

  const EnvironmentStatsWidget({
    super.key,
    required this.type,
    required this.value,
    this.customLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final config = _EnvironmentStatsConfig.fromType(type);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? config.darkGradientColors
                : config.lightGradientColors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: isDark
                      ? config.darkIconBackgroundColor
                      : config.lightIconBackgroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(
                  config.icon,
                  size: 24,
                  color: isDark
                      ? config.darkPrimaryColor
                      : config.lightPrimaryColor,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "${(value * 100).round()}%",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? config.darkPrimaryColor
                      : config.lightPrimaryColor,
                ),
              ),
              Text(
                customLabel ?? config.label,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              LinearProgressIndicator(
                value: value,
                minHeight: 6.0,
                color: isDark
                    ? config.darkPrimaryColor
                    : config.lightPrimaryColor,
                borderRadius: BorderRadius.circular(12),
                backgroundColor: isDark
                    ? config.darkProgressBackgroundColor
                    : config.lightProgressBackgroundColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EnvironmentStatsConfig {
  final IconData icon;
  final String label;
  final Color lightPrimaryColor;
  final Color darkPrimaryColor;
  final Color lightIconBackgroundColor;
  final Color darkIconBackgroundColor;
  final List<Color> lightGradientColors;
  final List<Color> darkGradientColors;
  final Color lightProgressBackgroundColor;
  final Color darkProgressBackgroundColor;

  const _EnvironmentStatsConfig({
    required this.icon,
    required this.label,
    required this.lightPrimaryColor,
    required this.darkPrimaryColor,
    required this.lightIconBackgroundColor,
    required this.darkIconBackgroundColor,
    required this.lightGradientColors,
    required this.darkGradientColors,
    required this.lightProgressBackgroundColor,
    required this.darkProgressBackgroundColor,
  });

  factory _EnvironmentStatsConfig.fromType(EnvironmentStatsType type) {
    switch (type) {
      case EnvironmentStatsType.humidity:
        return const _EnvironmentStatsConfig(
          icon: Icons.water_drop_outlined,
          label: "Humidity",
          lightPrimaryColor: Color(0xFF2563EB),
          darkPrimaryColor: Color(0xFF60A5FA),
          lightIconBackgroundColor: Color(0xFFDBEAFE),
          darkIconBackgroundColor: Color(0xFF1E3A8A),
          lightGradientColors: [Color(0x80EFF6FF), Color(0x80DBEAFE)],
          darkGradientColors: [Color(0x331E3A8A), Color(0x332155B6)],
          lightProgressBackgroundColor: Color(0xFFDBEAFE),
          darkProgressBackgroundColor: Color(0xFF1E3A8A),
        );
      case EnvironmentStatsType.foodLevel:
        return const _EnvironmentStatsConfig(
          icon: Icons.restaurant_outlined,
          label: "Food Level",
          lightPrimaryColor: Color(0xFFEA580C),
          darkPrimaryColor: Color(0xFFF97415),
          lightIconBackgroundColor: Color(0xFFFFEDD5),
          darkIconBackgroundColor: Color(0xFF7C2D12),
          lightGradientColors: [Color(0x80FFF7ED), Color(0x80FFEDD5)],
          darkGradientColors: [Color(0x33431407), Color(0x337C2D12)],
          lightProgressBackgroundColor: Color(0xFFFFEDD5),
          darkProgressBackgroundColor: Color(0xFF7C2D12),
        );
    }
  }
}
