import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class PointsHistoryPage extends StatelessWidget {
  const PointsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Points History', style: AppTypography.headlineMedium),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildHistoryItem();
        },
      ),
    );
  }

  Widget _buildHistoryItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline, color: Colors.green),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Purchase #BRW-452', style: AppTypography.labelMedium),
                Text('Oct 24, 2023', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
          ),
          Text('+45 pts', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }
}
