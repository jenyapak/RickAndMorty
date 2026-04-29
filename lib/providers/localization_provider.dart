import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _currentLocale = Locale('en');

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}
