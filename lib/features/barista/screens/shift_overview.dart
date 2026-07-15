import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class ShiftOverviewPage extends StatelessWidget {
  const ShiftOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Shift Metrics', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
                AppGlassContainer(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      _buildStatRow(context, 'Total Shots Pulled',
                          '${perf['ordersCompleted']}'),
                      _buildStatRow(context, 'Average extraction',
                          perf['avgBrewTime'] ?? 'N/A'),
                      _buildStatRow(context, 'Waste %', '2.1%'),
                      _buildStatRow(context, 'Efficiency Score',
                          '${perf['score']}%'),
                      _buildStatRow(context, 'Order Accuracy',
                          perf['accuracy'] ?? 'N/A'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTypography.bodyMedium(context)
                  .copyWith(color: AppColors.outline)),
          Text(value,
              style: AppTypography.dataMono(context)
                  .copyWith(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
