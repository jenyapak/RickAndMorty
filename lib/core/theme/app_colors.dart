import 'package:flutter/material.dart';

class AppColors {
  final Color textField;
  final Color activeStatus;
  final Color deadStatus;

  AppColors({
    required this.textField,
    required this.activeStatus,
    required this.deadStatus,
  });
}

class LightThemeColors implements AppColors {
  @override
  Color get textField => Color(0xffF2F2F2);

  @override
  Color get activeStatus => Color(0xff43D049);

  @override
  Color get deadStatus => Color(0xffEB5757);
}

class DarkThemeColors implements AppColors {
  @override
  Color get textField => Color(0xff152A3A);

  @override
  Color get activeStatus => Color(0xff43D049);

  @override
  Color get deadStatus => Color(0xffEB5757);
}
