import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF131313);
  static const Color surface = Color(0xFF131313);
  static const Color surfaceSecondary = Color(0xFF1D1D1D);
  static const Color primary = Color(0xFFE2C4A9);
  static const Color onPrimary = Color(0xFF3F2D1A);
  static const Color primaryContainer = Color(0xFFC5A98F);
  static const Color onPrimaryContainer = Color(0xFF523E29);
  static const Color secondary = Color(0xFFC8C6C5);
  static const Color onSecondary = Color(0xFF303030);
  static const Color tertiary = Color(0xFFE0C4AB);
  static const Color onTertiary = Color(0xFF3E2D1C);
  static const Color boneWhite = Color(0xFFE5E2E1);
  static const Color outline = Color(0xFF9A8F85);
  static const Color error = Color(0xFFFFB4AB);

  static Color glassBackground(double opacity) => surfaceSecondary.withValues(alpha: opacity);
}
