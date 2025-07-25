import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    // Define other theme properties for light mode
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      foregroundColor: Colors.white,
    ),
    // ...
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    brightness: Brightness.dark,
    // Define other theme properties for dark mode
    appBarTheme: const AppBarTheme(
      color: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),
    // ...
  );
}