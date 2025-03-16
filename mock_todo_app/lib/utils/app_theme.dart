import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF264653);
  static const Color accentColor = Color(0xFF2A9D8F);
  static const Color backgroundColor = Color(0xFFF1FAEE);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF2B2D42);
  static const Color textLightColor = Color(0xFF6C757D);
  static const Color dividerColor = Color(0xFFE5E5E5);

  // light theme -- will be changed.
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(primaryColor.value, {
      50: const Color(0xFFFFEBEE),
      100: const Color(0xFFFFCDD2),
      200: const Color(0xFFEF9A9A),
      300: const Color(0xFFE57373),
      400: const Color(0xFFEF5350),
      500: primaryColor,
      600: const Color(0xFFD32F2F),
      700: const Color(0xFFC62828),
      800: const Color(0xFFB71C1C),
      900: const Color(0xFF8B0000),
    }),
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: const CardTheme(
      color: cardColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: accentColor,
      surface: backgroundColor,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textLightColor),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: primaryColor,
      centerTitle: true,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: accentColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade700, width: 1),
      ),
      labelStyle: const TextStyle(color: textLightColor),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
      space: 1,
    ),
  );
}
