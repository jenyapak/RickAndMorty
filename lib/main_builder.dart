import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rick_and_morty/core/localization/generated/l10n.dart';
import 'package:rick_and_morty/core/theme/app_theme.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/all_characters_screen.dart';
import 'package:rick_and_morty/providers/app_theme_provider.dart';
import 'package:rick_and_morty/providers/localization_provider.dart';

class MainBuilder extends StatelessWidget {
  const MainBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      theme: LightAppTheme().themeData,
      darkTheme: DarkAppTheme().themeData,
      locale: context.watch<LocalizationProvider>().currentLocale,
      themeMode: context.watch<AppThemeProvider>().themeMode,

      home: AllCharactersListScreen(),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Language.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ky'),
        Locale('ru'), // Spanish
      ],
    );
  }
}
