import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/core/config/di.dart';
import 'package:rick_and_morty/main_builder.dart';
import 'package:rick_and_morty/providers/app_theme_provider.dart';
import 'package:rick_and_morty/providers/localization_provider.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: const MainBuilder(),
    );
  }
}
