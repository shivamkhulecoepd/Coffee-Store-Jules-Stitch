import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Store Manager', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
              Text('Monthly Overview', style: AppTypography.headlineMedium),
              SizedBox(height: 32.h),
              AppGlassContainer(
                height: 120.h,
                padding: EdgeInsets.all(24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRevenueStat('Total Revenue', r'2,500'),
                    const VerticalDivider(color: AppColors.surfaceSecondary),
                    _buildRevenueStat('Avg. Order', r'8.50'),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Text('Inventory Alerts', style: AppTypography.headlineMedium),
              SizedBox(height: 16.h),
              _buildInventoryAlert('Espresso Beans', 'Low Stock (12kg)', Colors.orange),
              _buildInventoryAlert('Whole Milk', 'Critically Low (5L)', Colors.red),
              SizedBox(height: 32.h),
              Text('Staff Performance', style: AppTypography.headlineMedium),
              SizedBox(height: 16.h),
              _buildStaffCard('Sarah Miller', '98% Efficiency'),
              _buildStaffCard('Alex Johnson', '94% Efficiency'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRevenueStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
        Text(value, style: AppTypography.headlineMedium.copyWith(color: AppColors.primary)),
      ],
    );
  }

  Widget _buildInventoryAlert(String item, String status, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: color),
            SizedBox(width: 16.w),
            Text(item, style: AppTypography.labelMedium),
            const Spacer(),
            Text(status, style: AppTypography.labelSmall.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildStaffCard(String name, String metric) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            CircleAvatar(radius: 20.r, backgroundColor: AppColors.surfaceSecondary, child: Text(name[0])),
            SizedBox(width: 16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTypography.labelMedium),
                Text(metric, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
            const Spacer(),
            Icon(Icons.keyboard_arrow_right, color: AppColors.outline),
          ],
        ),
      ),
    );
  }
}
