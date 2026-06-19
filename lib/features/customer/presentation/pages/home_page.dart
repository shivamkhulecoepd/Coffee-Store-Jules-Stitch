import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 40.h),
              _buildHeroSection(),
              SizedBox(height: 40.h),
              Text('CATEGORIES', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2)),
              SizedBox(height: 16.h),
              _buildCategories(),
              SizedBox(height: 40.h),
              Text('POPULAR SELECTIONS', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 2)),
              SizedBox(height: 16.h),
              _buildProductGrid(context),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LUXURY COFFEE', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 3)),
            Text('Bean & Brew', style: AppTypography.displayLargeMobile.copyWith(fontSize: 32.sp, fontWeight: FontWeight.w700)),
          ],
        ),
        AppGlassContainer(
          width: 56.w,
          height: 56.w,
          borderRadius: 28.r,
          padding: EdgeInsets.zero,
          child: Center(
            child: Icon(Icons.person_outline, color: AppColors.primary, size: 28.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return AppGlassContainer(
      height: 180.h,
      padding: EdgeInsets.all(24.w),
      boxShadow: AppTheme.premiumShadow,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('DAILY SPECIAL', style: AppTypography.labelSmall.copyWith(color: AppColors.primary, letterSpacing: 1.5)),
                SizedBox(height: 8.h),
                Text('25% OFF', style: AppTypography.displayLargeMobile.copyWith(fontSize: 38.sp)),
                Text('Premium Roast Selections', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
              ],
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Icon(Icons.coffee, size: 80.sp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 48.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip('ESPRESSO', true),
          _buildCategoryChip('COLD BREW', false),
          _buildCategoryChip('PASTRIES', false),
          _buildCategoryChip('BEANS', false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceSecondary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05)),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 24.h,
      crossAxisSpacing: 24.w,
      childAspectRatio: 0.7,
      children: [
        _buildProductCard(context, 'Vanilla Latte', '4.8', '5.50'),
        _buildProductCard(context, 'Macchiato', '4.9', '6.00'),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, String name, String rating, String price) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/details'),
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        boxShadow: AppTheme.premiumShadow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(child: Icon(Icons.coffee, size: 48.sp, color: AppColors.primary)),
              ),
            ),
            SizedBox(height: 16.h),
            Text(name, style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(r'$'+price, style: AppTypography.dataMono.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                Row(
                  children: [
                    Icon(Icons.star, size: 14.sp, color: AppColors.primary),
                    SizedBox(width: 4.w),
                    Text(rating, style: AppTypography.dataMono.copyWith(fontSize: 12.sp, color: AppColors.outline)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
