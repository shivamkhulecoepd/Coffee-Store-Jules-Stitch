import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  static final List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 40.r,
      offset: Offset(0, 20.h),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.05),
      blurRadius: 1,
      offset: const Offset(0, -1),
    ),
  ];

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryGold,
        surface: AppColors.surface,
        error: AppColors.error,
        onSurface: AppColors.boneWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.onPrimary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.onPrimary,
        secondary: AppColors.primary,
        surface: AppColors.crema,
        error: AppColors.error,
        onSurface: AppColors.textDark,
      ),
    );
  }
}
