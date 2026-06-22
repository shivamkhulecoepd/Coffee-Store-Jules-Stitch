import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.labelSmall(context).copyWith(
            color: AppColors.outline,
            fontSize: 10.sp,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          obscureText: isPassword,
          style: AppTypography.bodyMedium(context),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline.withOpacity(0.5)),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.primary, size: 20.sp) : null,
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
