import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/kpi_card.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

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
      body: StreamBuilder<Map<String, dynamic>>(
        stream: sl<StoreRepository>().performanceStream,
        initialData: sl<StoreRepository>().performance,
        builder: (context, snapshot) {
          final perf = snapshot.data ?? sl<StoreRepository>().performance;
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildScoreOverview(context, perf),
                SizedBox(height: 32.h),
                Text('METRICS',
                    style: AppTypography.labelSmall(context)
                        .copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 16.h),
                _buildMetricsGrid(context, perf),
                SizedBox(height: 32.h),
                Text('SESSION HISTORY',
                    style: AppTypography.labelSmall(context)
                        .copyWith(color: AppColors.primary, letterSpacing: 2)),
                SizedBox(height: 16.h),
                _buildHistoryList(context),
                SizedBox(height: 120.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildScoreOverview(
      BuildContext context, Map<String, dynamic> data) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DAILY SCORE',
                    style:
                        AppTypography.labelSmall(context).copyWith(color: AppColors.outline)),
                SizedBox(height: 4.h),
                Text('${data['score']}',
                    style: AppTypography.displayLargeMobile(context)
                        .copyWith(color: AppColors.success, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                  '${data['trend'] ?? '+0%'} from yesterday',
                  style: AppTypography.labelMedium(context)
                      .copyWith(color: AppColors.success, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: AppColors.success.withValues(alpha: 0.3), width: 8.w),
            ),
            child: Center(
              child: Text('A+',
                  style: AppTypography.headlineLarge(context)
                      .copyWith(color: AppColors.success)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(
      BuildContext context, Map<String, dynamic> data) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16.w,
      crossAxisSpacing: 16.w,
      childAspectRatio: 1.0,
      children: [
        KPICard(
          label: 'Avg Brew Time',
          value: data['avgBrewTime']?.toString() ?? 'N/A',
          chartData: const [5, 4, 3, 4, 3],
          chartColor: AppColors.primary,
        ),
        KPICard(
          label: 'Order Accuracy',
          value: data['accuracy']?.toString() ?? 'N/A',
          chartData: const [10, 10, 10, 10, 10],
          chartColor: AppColors.success,
        ),
        KPICard(
          label: 'Customer Rating',
          value: data['rating']?.toString() ?? 'N/A',
          chartData: const [4, 5, 4.5, 5, 4.9],
          chartColor: AppColors.primary,
        ),
        KPICard(
          label: 'Upsell Rate',
          value: data['upsell']?.toString() ?? 'N/A',
          chartData: const [2, 5, 8, 4, 12],
          chartColor: AppColors.primaryGold,
        ),
      ],
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    // Build session history from the orders in the repository
    final orders = sl<StoreRepository>().orders;
    if (orders.isEmpty) {
      return AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Text('No completed sessions yet.',
              style: AppTypography.bodySmall(context)),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length.clamp(0, 4),
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final order = orders[index];
        final items = order['items'] as List? ?? [];
        String brewName = 'Brew Session';
        if (items.isNotEmpty) {
          brewName = items.first['product']?['name'] ?? items.first['name'] ?? 'Brew Session';
        }
        return AppGlassContainer(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child:
                    Icon(Icons.timer_outlined, color: AppColors.primary, size: 18.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(brewName, style: AppTypography.labelMedium(context)),
                    Text('Completed in ~${order['status'] ?? 'N/A'}',
                        style: AppTypography.bodyMedium(context)
                            .copyWith(color: AppColors.outline, fontSize: 12.sp)),
                  ],
                ),
              ),
              Text('${order['total'] ?? '--'} pts',
                  style:
                      AppTypography.dataMono(context).copyWith(color: AppColors.success)),
            ],
          ),
        );
      },
    );
  }
}
