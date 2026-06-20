import 'package:flutter/material.dart';

class AppColors {
  // Dark Palette (Primary source of truth)
  static const Color backgroundDark = Color(0xFF131313);
  static const Color obsidian = Color(0xFF131313);
  static const Color surfaceDark = Color(0xFF1D1D1D);

  // Light Palette (Derived for Production readiness)
  static const Color backgroundLight = Color(0xFFFBFBFB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color neutralLight = Color(0xFFF2F2F2);

  // Brand Colors
  static const Color primary = Color(0xFFE2C4A9); // Light Taupe
  static const Color primaryGold = Color(0xFFC5A98F); // Metallic Gold
  static const Color onPrimary = Color(0xFF131313);

  static const Color crema = Color(0xFFF4ECE2);
  static const Color espressoBold = Color(0xFF2D1E17);

  static const Color boneWhite = Color(0xFFE5E2E1);
  static const Color textDark = Color(0xFF131313);
  static const Color outline = Color(0xFF9A8F85);
  static const Color error = Color(0xFFFFB4AB);
  static const Color success = Color(0xFFB4FFAB);

  static const List<Color> innerBorderGradient = [
    Color(0x1AFFFFFF),
    Colors.transparent,
  ];
}
