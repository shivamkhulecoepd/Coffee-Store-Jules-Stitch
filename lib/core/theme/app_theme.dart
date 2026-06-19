import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.primaryGold,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textDark,
        error: AppColors.error,
        outline: AppColors.outline,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.primaryGold,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.boneWhite,
        error: AppColors.error,
        outline: AppColors.outline,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }

  static List<BoxShadow> get premiumShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 40,
      offset: const Offset(0, 20),
    ),
  ];
}
