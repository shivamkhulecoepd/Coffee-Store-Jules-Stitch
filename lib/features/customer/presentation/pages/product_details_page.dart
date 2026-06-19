import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 480.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.espressoBold, AppColors.background],
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.coffee, size: 280.sp, color: AppColors.primary),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleIcon(context, Icons.arrow_back_ios_new, onTap: () => Navigator.pop(context)),
                      _buildCircleIcon(context, Icons.favorite_border),
                    ],
                  ),
                ),
                const Spacer(),
                AppGlassContainer(
                  height: 540.h,
                  borderRadius: 40.r,
                  padding: EdgeInsets.all(32.w),
                  boxShadow: AppTheme.premiumShadow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('SIGNATURE SERIES', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2.5)),
                                SizedBox(height: 4.h),
                                Text('Vanilla Latte', style: AppTypography.displayLargeMobile.copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          Text(r'.50', style: AppTypography.headlineLarge.copyWith(color: AppColors.primary, fontSize: 32.sp)),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      Text('DESCRIPTION', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                      SizedBox(height: 12.h),
                      Text(
                        'A velvety smooth double espresso balanced with steamed whole milk and our signature house-made Madagascar vanilla bean syrup. Crafted for the discerning palate.',
                        style: AppTypography.bodyMedium.copyWith(color: AppColors.boneWhite.withOpacity(0.65), height: 1.7),
                      ),
                      SizedBox(height: 40.h),
                      Text('CALIBRATE SIZE', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          _buildSizeOption('S', false),
                          _buildSizeOption('M', true),
                          _buildSizeOption('L', false),
                        ],
                      ),
                      const Spacer(),
                      AppButton(
                        text: 'ADD TO SELECTION',
                        onPressed: () => Navigator.pushNamed(context, '/cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIcon(BuildContext context, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        width: 48.w,
        height: 48.w,
        borderRadius: 24.r,
        shape: BoxShape.circle,
        padding: EdgeInsets.zero,
        child: Center(child: Icon(icon, color: Colors.white, size: 20.sp)),
      ),
    );
  }

  Widget _buildSizeOption(String size, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      width: 68.w,
      height: 68.w,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(18.r),
        border: isSelected ? null : Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Center(
        child: Text(
          size,
          style: AppTypography.headlineMedium.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
