import 'package:flutter/material.dart';

class WeeklyConsumptionWidget extends StatelessWidget {
  const WeeklyConsumptionWidget({super.key});

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
              gradient: isDark
                  ? null
                  : LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        theme.colorScheme.primary.withAlpha(
                          (255 * 0.10).toInt(),
                        ),
                        theme.colorScheme.primary.withAlpha(
                          (255 * 0.15).toInt(),
                        ),
                      ],
                    ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text("This Week", style: theme.textTheme.titleSmall),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "700g",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color(0xFF60A5FA)
                                  : const Color(0xFF2563EB),
                            ),
                          ),
                          Text(
                            "Total Dispensed",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "665g",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? const Color(0xFF34D399)
                                  : const Color(0xFF059669),
                            ),
                          ),
                          Text(
                            "Total Consumed",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 0.95,
                  minHeight: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: isDark
                      ? const Color(0xFF064E3B)
                      : const Color(0xFFD1FAE5),
                ),
                const SizedBox(height: 16),
                Text(
                  "95% average consumption",
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
