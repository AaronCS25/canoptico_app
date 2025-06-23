import 'package:flutter/material.dart';

class FormFieldContainer extends StatelessWidget {
  final Widget? child;
  final Widget? titleTrailing;
  final String? title;
  final String? subtitle;
  final String? errorMessage;

  const FormFieldContainer({
    super.key,
    this.child,
    this.title,
    this.subtitle,
    this.errorMessage,
    this.titleTrailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    const double smallSpacing = 4.0;
    const double mediumSpacing = 8.0;
    const double largeSpacing = 16.0;

    final titleStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: colorScheme.onSurface,
    );
    final subtitleStyle = textTheme.bodySmall;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Row(
            children: [
              Expanded(child: Text(title!, style: titleStyle)),
              if (titleTrailing != null) titleTrailing!,
            ],
          ),

        if (title != null) const SizedBox(height: smallSpacing),

        if (subtitle != null) ...[
          Text(subtitle!, style: subtitleStyle),
          const SizedBox(height: mediumSpacing),
        ] else if (title != null)
          const SizedBox(height: smallSpacing),

        if (child != null) child!,

        if (errorMessage != null) ...[
          const SizedBox(height: smallSpacing),
          Text(
            errorMessage!,
            style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
          ),
        ],

        const SizedBox(height: largeSpacing),
      ],
    );
  }
}
