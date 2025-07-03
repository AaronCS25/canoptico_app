import 'package:flutter/material.dart';

class FoodLevelWidget extends StatelessWidget {
  const FoodLevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border(
            left: BorderSide(color: theme.colorScheme.primary, width: 4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF7C2D12)
                        : const Color(0xFFFFEDD5),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Icon(
                    Icons.restaurant,
                    size: 16,
                    color: isDark
                        ? const Color(0xFFF97415)
                        : const Color(0xFFEA580C),
                  ),
                ),
                const SizedBox(width: 12),
                Text("Food Level", style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "78 %",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? const Color(0xFFF97415)
                    : const Color(0xFFEA580C),
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              minHeight: 8,
              color: theme.colorScheme.primary,
              value: 0.78,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: isDark
                  ? const Color(0xFF7C2D12)
                  : const Color(0xFFFFEDD5),
            ),
            const SizedBox(height: 8),
            Text(
              "Estimated 26 days remaining at current consumption rate",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
