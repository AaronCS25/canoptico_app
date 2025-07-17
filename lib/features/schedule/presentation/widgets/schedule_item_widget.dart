import 'package:flutter/material.dart';

class ScheduleItemWidget extends StatelessWidget {
  const ScheduleItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(
                      (255 * 0.10).toInt(),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("08:00", style: theme.textTheme.headlineMedium),
                    Text("50g", style: theme.textTheme.bodyMedium),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isDark
                        ? const Color(0xFFF97415)
                        : const Color(0xFFF97316),
                  ),
                  child: Text(
                    "Active",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark
                          ? const Color(0xFF0F172A)
                          : const Color(0xFFF8FAFC),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_outline_outlined, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Switch(
                  value: true,
                  activeColor: Colors.red,
                  onChanged: (bool value) {},
                ),
                const SizedBox(width: 8),
                Text(
                  "Conditional Dispensing",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? const Color(0xFFF8FAFC) : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF101929)
                    : const Color(0xFFFAFAF9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Only dispense if dish is below:",
                        style: theme.textTheme.bodySmall,
                      ),
                      Text(
                        "10%",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? const Color(0xFFF8FAFC)
                              : const Color(0xFF020817),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Slider(
                    padding: EdgeInsets.zero,
                    value: 0.8,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Will only dispense if dish is less than 10% full",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
