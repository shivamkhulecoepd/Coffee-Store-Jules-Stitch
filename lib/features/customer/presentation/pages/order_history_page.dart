import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Order History', style: AppTypography.headlineMedium),
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
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.receipt_long, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order #BRW-1234', style: AppTypography.labelMedium),
                Text('Oct 24, 2023 • 10:30 AM', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(r'2.50', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
              Text('Delivered', style: AppTypography.labelSmall.copyWith(color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}
