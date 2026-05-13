import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/theme/app_colors.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  static AppColors colors = DarkThemeColors();

  void changeThemeMode(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
    if (themeMode == ThemeMode.dark) {
      colors = DarkThemeColors();
    } else {
      colors = LightThemeColors();
    }
    notifyListeners();
  }
}
