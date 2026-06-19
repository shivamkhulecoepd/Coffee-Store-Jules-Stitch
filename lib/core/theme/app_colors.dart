import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF131313);
  static const Color surface = Color(0xFF131313);
  static const Color obsidian = Color(0xFF131313);
  static const Color surfaceSecondary = Color(0xFF1D1D1D);
  static const Color surfaceSecondaryGlass = Color(0xCC1D1D1D);

  static const Color primary = Color(0xFFE2C4A9);
  static const Color primaryGold = Color(0xFFC5A98F);
  static const Color onPrimary = Color(0xFF131313);

  static const Color secondary = Color(0xFF9A8F85);
  static const Color onSecondary = Color(0xFF131313);

  static const Color crema = Color(0xFFF4ECE2);
  static const Color espressoBold = Color(0xFF2D1E17);

  static const Color boneWhite = Color(0xFFE5E2E1);
  static const Color outline = Color(0xFF9A8F85);
  static const Color error = Color(0xFFFFB4AB);
  static const Color success = Color(0xFFB4FFAB);

  static const List<Color> innerBorderGradient = [
    Color(0x1AFFFFFF),
    Colors.transparent,
  ];

  static Color glassBackground(double opacity) => surfaceSecondary.withOpacity(opacity);
}
