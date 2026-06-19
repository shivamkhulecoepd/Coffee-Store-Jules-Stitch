import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      decoration: BoxDecoration(
        boxShadow: isPrimary ? AppTheme.premiumShadow : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
          foregroundColor: isPrimary ? AppColors.onPrimary : AppColors.primary,
          side: isPrimary ? null : BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          text.toUpperCase(),
          style: AppTypography.labelSmall(context).copyWith(
            color: isPrimary ? AppColors.onPrimary : AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
