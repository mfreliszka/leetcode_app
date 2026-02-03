import 'package:flutter/material.dart';

// Difficulty Colors
const kEasyColor = Color(0xFF4CAF50);
const kMediumColor = Color(0xFFFF9800);
const kHardColor = Color(0xFFF44336);
// Accent
const kAccentColor = Color(0xFF2196F3);

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: kAccentColor,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.bold),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: kAccentColor,
      unselectedItemColor: Colors.black54,
      type: BottomNavigationBarType.fixed,
    ),
  );
}