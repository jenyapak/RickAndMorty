import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/theme/app_colors.dart';
import 'package:rick_and_morty/providers/app_theme_provider.dart';

extension ContextExtension on BuildContext {
  AppColors get colors => AppThemeProvider.colors;
}
