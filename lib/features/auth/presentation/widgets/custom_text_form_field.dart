import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? errorMessage;
  final bool isEnabled;
  final bool obscureText;
  final bool induceError;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.label,
    this.errorMessage,
    this.isEnabled = true,
    this.obscureText = false,
    this.induceError = false,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final inputTheme = theme.inputDecorationTheme;

    final OutlineInputBorder baseBorder =
        (inputTheme.border as OutlineInputBorder?) ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.outlineVariant),
        );

    final focusBorder = baseBorder.copyWith(
      borderSide: BorderSide(color: colors.primary),
    );
    final errorBorder = baseBorder.copyWith(
      borderSide: BorderSide(color: colors.error),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      enabled: isEnabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: colors.onSurface,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.textTheme.labelLarge?.color,
      ),
      decoration: InputDecoration(
        enabledBorder: induceError ? errorBorder : baseBorder,
        disabledBorder: induceError ? errorBorder : baseBorder,
        focusedBorder: induceError ? errorBorder : focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        labelText: label,
        labelStyle: theme.textTheme.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        errorText: errorMessage,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ).applyDefaults(inputTheme),
    );
  }
}
