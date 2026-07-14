import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: AppTypography.labelSmall(context).copyWith(
            color: AppColors.outline,
            fontSize: 10.sp,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          style: AppTypography.bodyMedium(context),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline.withValues(alpha: 0.5)),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.primary, size: 20.sp)
                : null,
            suffixIcon: _buildSuffixIcon(),
            filled: true,
            fillColor: Colors.black.withValues(alpha: 0.3),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
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

  Widget? _buildSuffixIcon() {
    // Password show/hide toggle
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.outline,
          size: 20.sp,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }
}
