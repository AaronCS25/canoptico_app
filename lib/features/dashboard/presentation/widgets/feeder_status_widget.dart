import 'package:flutter/material.dart';

enum FeederStatus { ready, dispensing, full }

class _FeederColors {
  static const Color ready = Color(0xFF34D399);
  static const Color dispensing = Color(0xFFFBBF24);
  static const Color full = Color(0xFFEF4444);
}

class FeederStatusWidget extends StatelessWidget {
  final FeederStatus status;
  final DateTime lastFed;
  final double lastFedGrams;
  final double dishFullness;
  final VoidCallback? onDispensePressed;

  const FeederStatusWidget({
    super.key,
    required this.status,
    required this.lastFed,
    required this.lastFedGrams,
    required this.dishFullness,
    this.onDispensePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final _FeederConfig config = _getConfig(status, onDispensePressed, theme);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: config.padding,
        decoration: config.decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    config.statusIcon,
                    const SizedBox(width: 8),
                    Text(config.title, style: theme.textTheme.titleSmall),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  decoration: config.badgeDecoration,
                  child: Text(
                    config.badge,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Last fed: Today at ${_formatTime(lastFed)} ($lastFedGrams g)",
            ),
            const SizedBox(height: 12),
            if (status == FeederStatus.full) _buildWarningMessage(theme),
            ElevatedButton.icon(
              icon: config.buttonIcon,
              label: Text(config.buttonText),
              style: config.buttonStyle,
              onPressed: config.onDispensePressed,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dish Fullness", style: theme.textTheme.bodyMedium),
                Text(
                  "$dishFullness%",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              minHeight: 8,
              color: config.linearProgressColor,
              value: dishFullness / 100,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: config.sideColor.withValues(alpha: 0.1),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  _FeederConfig _getConfig(
    FeederStatus status,
    VoidCallback? onDispensePressed,
    ThemeData theme,
  ) {
    final padding = const EdgeInsets.all(16);
    final isDark = theme.brightness == Brightness.dark;

    switch (status) {
      case FeederStatus.ready:
        return _FeederConfig(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF064E3B).withValues(alpha: 0.2)
                : const Color(0xFFECFDF5).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(color: _FeederColors.ready, width: 4),
            ),
          ),
          sideColor: _FeederColors.ready,
          padding: padding,
          statusIcon: const Icon(
            Icons.circle,
            size: 12,
            color: _FeederColors.ready,
          ),
          title: "Ready",
          badge: "Ready",
          badgeDecoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          buttonIcon: const Icon(Icons.play_arrow_rounded),
          buttonText: "Dispense Food Now",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(48),
          ),
          onDispensePressed: onDispensePressed,
          linearProgressColor: theme.colorScheme.primary,
        );
      case FeederStatus.dispensing:
        return _FeederConfig(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF451A03).withValues(alpha: 0.2)
                : const Color(0xFFFFFBEB).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(color: _FeederColors.dispensing, width: 4),
            ),
          ),
          sideColor: _FeederColors.dispensing,
          padding: padding,
          statusIcon: const Icon(
            Icons.circle,
            size: 12,
            color: _FeederColors.dispensing,
          ),
          title: "Dispensing...",
          badge: "Active",
          badgeDecoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          buttonIcon: const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          buttonText: "Dispensing...",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.grey,
            minimumSize: const Size.fromHeight(48),
          ),
          onDispensePressed: null,
          linearProgressColor: theme.colorScheme.primary,
        );
      case FeederStatus.full:
        return _FeederConfig(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF450A0A).withValues(alpha: 0.2)
                : const Color(0xFFFEF2F2).withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: const Border(
              left: BorderSide(color: _FeederColors.full, width: 4),
            ),
          ),
          sideColor: _FeederColors.full,
          padding: padding,
          statusIcon: const Icon(
            Icons.circle,
            size: 12,
            color: _FeederColors.full,
          ),
          title: "Dish Full",
          badge: "Ready",
          badgeDecoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          buttonIcon: const Icon(Icons.play_arrow_rounded),
          buttonText: "Dispense Food Now",
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.grey,
            minimumSize: const Size.fromHeight(48),
          ),
          onDispensePressed: null,
          linearProgressColor: theme.colorScheme.primary,
        );
    }
  }

  Widget _buildWarningMessage(ThemeData theme) {
    final padding = const EdgeInsets.all(12);
    final margin = const EdgeInsets.only(bottom: 12);

    final decoration = BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
    );

    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Dish is full. Please wait until your cat eats some food.",
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.red.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeederConfig {
  final BoxDecoration decoration;
  final Color sideColor;
  final EdgeInsetsGeometry padding;
  final Icon statusIcon;
  final String title;
  final String badge;
  final BoxDecoration badgeDecoration;
  final Widget? buttonIcon;
  final String buttonText;
  final ButtonStyle buttonStyle;
  final VoidCallback? onDispensePressed;
  final Color linearProgressColor;

  const _FeederConfig({
    required this.decoration,
    required this.sideColor,
    required this.padding,
    required this.statusIcon,
    required this.title,
    required this.badge,
    required this.badgeDecoration,
    this.buttonIcon,
    required this.buttonText,
    required this.buttonStyle,
    this.onDispensePressed,
    required this.linearProgressColor,
  });
}
