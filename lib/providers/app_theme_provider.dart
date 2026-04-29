import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  void changeThemeMode(ThemeMode newThemeMode) {
    themeMode = newThemeMode;
    notifyListeners();
  }
}
