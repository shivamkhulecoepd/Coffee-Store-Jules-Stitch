import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle displayLarge(BuildContext context) => GoogleFonts.manrope(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    height: 1.1,
    letterSpacing: -0.02.sp,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle displayLargeMobile(BuildContext context) => GoogleFonts.manrope(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.manrope(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle headlineMedium(BuildContext context) => GoogleFonts.manrope(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle labelMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.05.sp,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 1.2.sp,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );

  static TextStyle dataMono(BuildContext context) => GoogleFonts.manrope(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.02.sp,
    color: Theme.of(context).brightness == Brightness.dark ? AppColors.boneWhite : AppColors.textDark,
  );
}
