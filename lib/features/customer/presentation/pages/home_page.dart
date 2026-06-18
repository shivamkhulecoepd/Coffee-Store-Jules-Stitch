import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 32.h),
              _buildHeroSection(),
              SizedBox(height: 32.h),
              Text('Categories', style: AppTypography.headlineMedium),
              SizedBox(height: 16.h),
              _buildCategories(),
              SizedBox(height: 32.h),
              Text('Popular Now', style: AppTypography.headlineMedium),
              SizedBox(height: 16.h),
              _buildProductGrid(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.outline,
              ),
            ),
            Text('Alex Johnson', style: AppTypography.headlineMedium),
          ],
        ),
        CircleAvatar(
          radius: 24.r,
          backgroundColor: AppColors.surfaceSecondary,
          child: Icon(
            Icons.person_outline,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return AppGlassContainer(
      height: 180.h,
      padding: EdgeInsets.all(24.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MORNING BREW',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text('25% OFF', style: AppTypography.displayLargeMobile),
                  Text(
                    'On your first order today',
                    style: AppTypography.bodyMedium,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.coffee,
              size: 80.sp,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryChip('All Coffee', true),
          _buildCategoryChip('Espresso', false),
          _buildCategoryChip('Cold Brew', false),
          _buildCategoryChip('Pastries', false),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? AppColors.onPrimary : AppColors.boneWhite,
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
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 0.75,
      children: [
        _buildProductCard(context, 'Vanilla Latte', '4.8', '5.50'),
        _buildProductCard(context, 'Caramel Macchiato', '4.9', '6.00'),
        _buildProductCard(context, 'Vanilla Latte', '4.8', '5.50'),
        _buildProductCard(context, 'Caramel Macchiato', '4.9', '6.00'),
        _buildProductCard(context, 'Vanilla Latte', '4.8', '5.50'),
        _buildProductCard(context, 'Caramel Macchiato', '4.9', '6.00'),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String name,
    String rating,
    String price,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        AppAnimations.fadePageRoute(const ProductDetailsPage()),
      ),
      child: AppGlassContainer(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Hero(
                    tag: name,
                    child: Icon(
                      Icons.coffee,
                      size: 40.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                right: 8.w,
                top: 12.h,
                bottom: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: AppTypography.labelMedium),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r'$' + price,
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 14.sp, color: Colors.amber),
                          Text(rating, style: AppTypography.labelSmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return AppGlassContainer(
      height: 80.h,
      borderRadius: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, true, () {}),
          _buildNavItem(Icons.search, false, () => Navigator.pushNamed(context, '/discover')),
          _buildNavItem(Icons.shopping_bag_outlined, false, () => Navigator.pushNamed(context, '/cart')),
          _buildNavItem(Icons.favorite_border, false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isActive ? AppColors.primary : AppColors.outline,
        size: 28.sp,
      ),
    );
  }
}
