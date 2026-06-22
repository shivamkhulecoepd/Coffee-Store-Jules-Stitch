import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/kpi_card.dart';

class BaristaPerformancePage extends StatelessWidget {
  const BaristaPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Performance', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreOverview(context),
            SizedBox(height: 32.h),
            Text('METRICS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 16.h),
            _buildMetricsGrid(context),
            SizedBox(height: 32.h),
            Text('SESSION HISTORY', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 16.h),
            _buildHistoryList(context),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreOverview(BuildContext context) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DAILY SCORE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 4.h),
                Text('98.4', style: AppTypography.displayLargeMobile(context).copyWith(color: AppColors.success, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text('+2.1% from yesterday', style: AppTypography.labelMedium(context).copyWith(color: AppColors.success, fontSize: 11.sp)),
              ],
            ),
          ),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.success.withOpacity(0.3), width: 8.w),
            ),
            child: Center(
              child: Text('A+', style: AppTypography.headlineLarge(context).copyWith(color: AppColors.success)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.w,
      crossAxisSpacing: 16.w,
      childAspectRatio: 1.2.w,
      children: const [
        KPICard(label: 'Avg Brew Time', value: '2:14m', chartData: [5, 4, 3, 4, 3], chartColor: AppColors.primary),
        KPICard(label: 'Order Accuracy', value: '100%', chartData: [10, 10, 10, 10, 10], chartColor: AppColors.success),
        KPICard(label: 'Customer Rating', value: '4.9', chartData: [4, 5, 4.5, 5, 4.9], chartColor: AppColors.primary),
        KPICard(label: 'Upsell Rate', value: '12%', chartData: [2, 5, 8, 4, 12], chartColor: AppColors.primaryGold),
      ],
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return AppGlassContainer(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(Icons.timer_outlined, color: AppColors.primary, size: 18.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('V60 Pour Over - Single Origin', style: AppTypography.labelMedium(context)),
                    Text('Completed in 3:45m', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                  ],
                ),
              ),
              Text('98 pts', style: AppTypography.dataMono(context).copyWith(color: AppColors.success)),
            ],
          ),
        );
      },
    );
  }
}
