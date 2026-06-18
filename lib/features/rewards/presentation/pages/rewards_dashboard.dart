import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class RewardsDashboard extends StatelessWidget {
  const RewardsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Rewards', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              height: 200.h,
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('COFFEE POINTS', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
                  SizedBox(height: 8.h),
                  Text('2,450', style: AppTypography.displayLarge),
                  SizedBox(height: 16.h),
                  Text('550 points until your next free cup', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Available Rewards'),
            SizedBox(height: 16.h),
            _buildRewardItem('Free Espresso', '500 pts'),
            _buildRewardItem('Seasonal Muffin', '800 pts'),
            _buildRewardItem('Custom Coffee Mug', '2500 pts'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
    );
  }

  Widget _buildRewardItem(String title, String cost) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Icon(Icons.card_giftcard, color: AppColors.primary),
            SizedBox(width: 16.w),
            Expanded(child: Text(title, style: AppTypography.labelMedium)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(cost, style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
