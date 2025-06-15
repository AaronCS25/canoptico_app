import 'package:flutter/material.dart';

class FeedingHistoryCard extends StatelessWidget {
  const FeedingHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: theme.cardTheme.shape,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 12, color: Color(0xFF10B981)),
            const SizedBox(width: 12),
            Column(
              children: [
                Text("18:00", style: theme.textTheme.titleSmall),
                Text("Today", style: theme.textTheme.bodyMedium),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "Given: 50g",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFFF8FAFC)
                        : const Color(0xFF020817),
                  ),
                ),
                Text(
                  "Eaten: 45g",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? const Color(0xFF34D399)
                        : const Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
