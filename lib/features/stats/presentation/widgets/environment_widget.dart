import 'package:flutter/material.dart';

class EnvironmentWidget extends StatelessWidget {
  final double humidity;

  const EnvironmentWidget({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF172554).withValues(alpha: 0.20),
                        const Color(0xFF1e3a8a).withValues(alpha: 0.20),
                      ]
                    : [
                        const Color(0xFFeff6ff).withValues(alpha: 0.50),
                        const Color(0xFFdbeafe).withValues(alpha: 0.50),
                      ],
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.water_drop_outlined,
                  size: 16,
                  color: isDark
                      ? const Color(0xFF60A5FA)
                      : const Color(0xFF2563EB),
                ),
                const SizedBox(width: 8.0),
                Text("Environment", style: theme.textTheme.titleSmall),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsGeometry.only(
              left: 24,
              top: 12,
              right: 24,
              bottom: 24,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Current Humidity", style: theme.textTheme.bodyMedium),
                    Text("$humidity%", style: theme.textTheme.titleSmall),
                  ],
                ),
                const SizedBox(height: 12.0),
                LinearProgressIndicator(
                  value: 0.62,
                  minHeight: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: isDark
                      ? const Color(0xFF1E3A8A)
                      : const Color(0xFFDBEAFE),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(color: Color(0xFFF7F9FB)),
                  child: Text(
                    "Optimal range: 40-70%. Current level is perfect for your cat's comfort.",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
