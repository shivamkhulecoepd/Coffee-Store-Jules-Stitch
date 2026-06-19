import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
            height: 400.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2D1E17), AppColors.background],
              ),
            ),
            child: Center(
              child: Icon(Icons.coffee, size: 200.sp, color: AppColors.primary.withOpacity(0.1)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: _buildCircleIcon(Icons.arrow_back),
                      ),
                      _buildCircleIcon(Icons.favorite_border),
                    ],
                  ),
                ),
                const Spacer(),
                AppGlassContainer(
                  height: 480.h,
                  borderRadius: 40,
                  padding: EdgeInsets.all(32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Signature', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
                              Text('Vanilla Latte', style: AppTypography.displayLargeMobile),
                            ],
                          ),
                          Text(r'.50', style: AppTypography.headlineMedium.copyWith(color: AppColors.primary)),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Text('A velvety smooth espresso balanced with steamed milk and our house-made Madagascar vanilla syrup.', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
                      SizedBox(height: 32.h),
                      Text('Size', style: AppTypography.labelMedium),
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
                        text: 'Add to Cart',
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

  Widget _buildCircleIcon(IconData icon) {
    return AppGlassContainer(
      width: 48.w,
      height: 48.w,
      borderRadius: 24.r,
      shape: BoxShape.circle,
      child: Center(child: Icon(icon, color: Colors.white, size: 24.sp)),
    );
  }

  Widget _buildSizeOption(String size, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 16.w),
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        border: isSelected ? null : Border.all(color: AppColors.surfaceSecondary),
      ),
      child: Center(
        child: Text(
          size,
          style: AppTypography.headlineMedium.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
          ),
        ),
      ),
    );
  }
}
