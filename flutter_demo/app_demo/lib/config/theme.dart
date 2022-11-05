import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFFE6AA68),
      secondary: const Color(0xFFFFFBBD),
      surface: Colors.white,
      background: Colors.black87,
      onBackground: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
    ),
  );
}
