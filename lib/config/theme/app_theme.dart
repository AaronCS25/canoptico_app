import 'package:flutter/material.dart';

class AppTheme {
  static const String fontFamily = 'Inter';

  static ThemeData warmTheme = ThemeData(
    fontFamily: fontFamily,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF97415),
      onPrimary: Color(0xFFFAFAF9),
      secondary: Color(0xFFF5F5F4),
      onSecondary: Color(0xFF1C1917),
      surface: Color(0xFFFFFBF0),
      onSurface: Color(0xFF0C0A09),
      error: Color(0xFFEF4444),
      onError: Color(0xFFFAFAF9),
    ),
    dividerColor: const Color(0xFFE5E7EB),
    scaffoldBackgroundColor: const Color(0xFFFFFBF0),
    textTheme: _buildTextTheme(_warmTextColors),
    cardTheme: _cardTheme(const Color(0xFFFFFFFF), const Color(0xFFE7E5E4)),
    elevatedButtonTheme: _primaryButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFFFAFAF9),
    ),
    filledButtonTheme: _filledButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFFFAFAF9),
    ),
    textButtonTheme: _textButtonTheme(const Color(0xFFF97415)),
    inputDecorationTheme: _inputDecorationTheme(const Color(0xFFE7E5E4)),
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: fontFamily,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFF97415),
      onPrimary: Color(0xFFF8FAFC),
      secondary: Color(0xFFF1F5F9),
      onSecondary: Color(0xFF0F172A),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF020617),
      error: Color(0xFFEF4444),
      onError: Color(0xFFF8FAFC),
    ),
    dividerColor: const Color(0xFFE2E8F0),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    textTheme: _buildTextTheme(_lightTextColors),
    cardTheme: _cardTheme(const Color(0xFFFFFFFF), const Color(0xFFE2E8F0)),
    elevatedButtonTheme: _primaryButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFFF8FAFC),
    ),
    filledButtonTheme: _filledButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFFF8FAFC),
    ),
    textButtonTheme: _textButtonTheme(const Color(0xFFF97415)),
    inputDecorationTheme: _inputDecorationTheme(const Color(0xFFE2E8F0)),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: fontFamily,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFF97415),
      onPrimary: Color(0xFF0F172A),
      secondary: Color(0xFF1E293B),
      onSecondary: Color(0xFFF8FAFC),
      surface: Color(0xFF020617),
      onSurface: Color(0xFFF8FAFC),
      error: Color(0xFFDC2626),
      onError: Color(0xFFF8FAFC),
    ),
    dividerColor: const Color(0xFF334155),
    scaffoldBackgroundColor: const Color(0xFF020617),
    textTheme: _buildTextTheme(_darkTextColors),
    cardTheme: _cardTheme(const Color(0xFF020617), const Color(0xFF1E293B)),
    elevatedButtonTheme: _primaryButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFF0F172A),
    ),
    filledButtonTheme: _filledButtonTheme(
      const Color(0xFFF97415),
      const Color(0xFF0F172A),
    ),
    textButtonTheme: _textButtonTheme(const Color(0xFFF97415)),
    inputDecorationTheme: _inputDecorationTheme(const Color(0xFF1E293B)),
  );

  static TextTheme _buildTextTheme(Map<String, Color> colors) {
    return TextTheme(
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colors['bodySmall'],
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colors['bodyMedium'],
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: colors['titleSmall'],
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: colors['label'],
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: colors['label'],
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: colors['label'],
      ),
      headlineLarge: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      headlineMedium: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static CardThemeData _cardTheme(Color background, Color border) {
    return CardThemeData(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: border),
      ),
      elevation: 1,
      margin: const EdgeInsets.all(8),
    );
  }

  static ElevatedButtonThemeData _primaryButtonTheme(
    Color backgroundColor,
    Color textColor,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),
    );
  }

  static FilledButtonThemeData _filledButtonTheme(
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(Color textColor) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(Color borderColor) {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF8C42)),
      ),
    );
  }

  // Color maps por tema
  static const _warmTextColors = {
    'bodySmall': Color(0xFF78716C),
    'bodyMedium': Color(0xFF78716C),
    'titleSmall': Color(0xFF0C0A09),
    'label': Color(0xFF0C0A09),
  };

  static const _lightTextColors = {
    'bodySmall': Color(0xFF64748B),
    'bodyMedium': Color(0xFF64748B),
    'titleSmall': Color(0xFF020617),
    'label': Color(0xFF020617),
  };

  static const _darkTextColors = {
    'bodySmall': Color(0xFF94A3B8),
    'bodyMedium': Color(0xFF94A3B8),
    'titleSmall': Color(0xFFF8FAFC),
    'label': Color(0xFFF8FAFC),
  };
}
