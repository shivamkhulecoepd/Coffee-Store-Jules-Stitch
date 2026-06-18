import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class BaristaPerformancePage extends StatelessWidget {
  const BaristaPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Performance', style: AppTypography.headlineMedium),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              height: 180.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('EFFICIENCY RATING', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
                  SizedBox(height: 16.h),
                  Text('94%', style: AppTypography.displayLarge),
                  SizedBox(height: 8.h),
                  Text('Top 5% in the region', style: AppTypography.labelSmall.copyWith(color: Colors.green)),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildMetricRow('Average Brew Time', '2m 15s'),
            SizedBox(height: 16.h),
            _buildMetricRow('Customer Rating', '4.9/5'),
            SizedBox(height: 16.h),
            _buildMetricRow('Orders Completed', '156'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return AppGlassContainer(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.labelMedium),
          Text(value, style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
