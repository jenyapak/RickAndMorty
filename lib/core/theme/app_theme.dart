import 'package:flutter/material.dart';

abstract class AppTheme {
  ThemeData get themeData;
}

class LightAppTheme extends AppTheme {
  @override
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: Color(0xffFCFCFC),
    brightness: Brightness.light,
    iconTheme: const IconThemeData(color: Color(0xff5B6975)),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Color(0xff0B1E2D)),
      bodyLarge: TextStyle(color: Color(0xff0B1E2D)),
      bodySmall: TextStyle(color: Color(0xff0B1E2D)),
      displayLarge: TextStyle(color: Color(0xff0B1E2D)),
      displayMedium: TextStyle(color: Color(0xff0B1E2D)),
      displaySmall: TextStyle(color: Color(0xff0B1E2D)),
      headlineMedium: TextStyle(color: Color(0xff0B1E2D)),
      headlineSmall: TextStyle(color: Color(0xff0B1E2D)),
      titleMedium: TextStyle(color: Color(0xff0B1E2D)),
      titleSmall: TextStyle(color: Color(0xff0B1E2D)),
    ),
  );
}

class DarkAppTheme extends AppTheme {
  @override
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: Color(0xff0B1E2D),
    brightness: Brightness.dark,
    iconTheme: const IconThemeData(color: Color(0xff5B6975)),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
  );
}
