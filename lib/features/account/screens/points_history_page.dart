import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class PointsHistoryPage extends StatelessWidget {
  const PointsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Credit History', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final isEarning = index % 2 == 0;
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: (isEarning ? AppColors.success : AppColors.primary).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isEarning ? Icons.add_circle_outline : Icons.remove_circle_outline,
                    color: isEarning ? AppColors.success : AppColors.primary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEarning ? 'Purchase Reward' : 'Redemption',
                        style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        isEarning ? 'Order #ST-421' : 'Artisan Espresso',
                        style: AppTypography.bodySmall(context),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isEarning ? "+" : "-"}${isEarning ? 50 : 500} PTS',
                      style: AppTypography.dataMono(context).copyWith(
                        color: isEarning ? AppColors.success : AppColors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text('Oct 24', style: AppTypography.bodySmall(context).copyWith(fontSize: 10.sp)),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
