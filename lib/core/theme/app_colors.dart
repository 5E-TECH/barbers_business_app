import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0B0C17);
  static const Color yellow = Color(0xFFFA8B01);
  static const Color background = Color(0xFF1B1D2E);
  static const Color backgroundContainer = Color(0xFF5C4033);
}

class AppTheme {
  // Light theme (if you want)
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.primary, // text/icon color
      ),
    ),
    dialogBackgroundColor: AppColors.background,
    cardColor: AppColors.backgroundContainer,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: Colors.grey,
    ),
  );

  // Dark theme (optional)
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.primary,
      ),
    ),
    dialogBackgroundColor: AppColors.background,
    cardColor: AppColors.backgroundContainer,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: Colors.grey,
    ),
  );
}
