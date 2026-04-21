import 'package:flutter/material.dart';
import 'package:rick_and_morty/modules/all_characters/presentation/all_characters_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',

      home: const AllCharactersListScreen(),
    );
  }
}
