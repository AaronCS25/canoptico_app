part of 'theme_cubit.dart';

enum ThemeSetting { light, dark, warm }

class ThemeState {
  final ThemeSetting themeMode;
  final ThemeData themeData;

  ThemeState({this.themeMode = ThemeSetting.warm, ThemeData? themeData})
    : themeData = themeData ?? AppTheme.warmTheme;

  ThemeState copyWith({ThemeSetting? themeMode, ThemeData? themeData}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      themeData: themeData ?? this.themeData,
    );
  }
}
