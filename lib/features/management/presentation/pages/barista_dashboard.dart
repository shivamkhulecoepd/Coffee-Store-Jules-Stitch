import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class BaristaDashboard extends StatelessWidget {
  const BaristaDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Barista Dashboard', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
                      Text('Morning Shift', style: AppTypography.headlineMedium),
                    ],
                  ),
                  _buildStatusBadge('ONLINE', Colors.green),
                ],
              ),
              SizedBox(height: 32.h),
              _buildStatsRow(),
              SizedBox(height: 32.h),
              Text('Active Orders', style: AppTypography.headlineMedium),
              SizedBox(height: 16.h),
              _buildActiveOrdersList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Orders', '24', Icons.receipt_long)),
        SizedBox(width: 16.w),
        Expanded(child: _buildStatCard('Wait Time', '4m', Icons.timer_outlined)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      height: 100.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
              Icon(icon, size: 16.sp, color: AppColors.primary),
            ],
          ),
          Text(value, style: AppTypography.headlineMedium),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        return AppGlassContainer(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ORDER #421', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
                  Text('2x Vanilla Latte', style: AppTypography.labelMedium),
                  Text('Table 4', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
              const Spacer(),
              _buildStatusBadge('IN PROGRESS', AppColors.primary),
            ],
          ),
        );
      },
    );
  }
}
