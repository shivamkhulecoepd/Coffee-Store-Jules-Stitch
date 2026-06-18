import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ShiftOverviewPage extends StatelessWidget {
  const ShiftOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Daily Shift Overview', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  _buildShiftDetail('Current Shift', 'Morning (06:00 - 14:00)'),
                  const Divider(color: AppColors.surfaceSecondary),
                  _buildShiftDetail('Active Staff', 'Alex, Sarah, Mike'),
                  const Divider(color: AppColors.surfaceSecondary),
                  _buildShiftDetail('Total Sales', r',240.50'),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildSectionHeader('Announcements'),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(20.w),
              child: Text(
                'Reminder: New seasonal blend "Autumn Harvest" launches tomorrow. Ensure all signage is updated.',
                style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
              ),
            ),
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

  Widget _buildShiftDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
          Text(value, style: AppTypography.labelMedium),
        ],
      ),
    );
  }
}
