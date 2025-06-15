import 'package:flutter/material.dart';

class DailySummaryWidget extends StatelessWidget {
  const DailySummaryWidget({super.key});

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
                    ? [const Color(0x33022C22), const Color(0x33064E3B)]
                    : [const Color(0x80ECFDF5), const Color(0x80D1FAE5)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF064E3B)
                        : const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Icon(
                    Icons.stacked_bar_chart_outlined,
                    size: 16,
                    color: isDark
                        ? const Color(0xFF34D399)
                        : const Color(0xFF059669),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text("Today's Summary", style: theme.textTheme.titleSmall),
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
                    Text("Dispensed", style: theme.textTheme.bodyMedium),
                    Text("100g", style: theme.textTheme.titleSmall),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Consumed", style: theme.textTheme.bodyMedium),
                    Text(
                      "95g",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: isDark
                            ? const Color(0xFF34D399)
                            : const Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                LinearProgressIndicator(
                  value: 0.95,
                  minHeight: 8.0,
                  borderRadius: BorderRadius.circular(8.0),
                  color: Theme.of(context).colorScheme.primary,
                  backgroundColor: isDark
                      ? const Color(0xFF064E3B)
                      : const Color(0xFFD1FAE5),
                ),
                const SizedBox(height: 8.0),
                Text("95% consumption ", style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
