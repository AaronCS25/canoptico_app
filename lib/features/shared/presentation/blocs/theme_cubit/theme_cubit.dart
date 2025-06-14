import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState());

  void setThemeMode(ThemeSetting themeMode) {
    ThemeData themeData;

    switch (themeMode) {
      case ThemeSetting.light:
        themeData = AppTheme.lightTheme;
        break;
      case ThemeSetting.dark:
        themeData = AppTheme.darkTheme;
        break;
      case ThemeSetting.warm:
        themeData = AppTheme.warmTheme;
        break;
    }

    emit(state.copyWith(themeMode: themeMode, themeData: themeData));
  }
}
