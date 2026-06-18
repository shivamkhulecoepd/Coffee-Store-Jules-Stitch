import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class CustomerRequestsPage extends StatelessWidget {
  const CustomerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Customer Requests', style: AppTypography.headlineMedium),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildRequestItem();
        },
      ),
    );
  }

  Widget _buildRequestItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Support ID #REQ-982', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
              Text('2h ago', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
            ],
          ),
          SizedBox(height: 12.h),
          Text('Issue with Loyalty Points', style: AppTypography.labelMedium),
          SizedBox(height: 8.h),
          Text(
            'The customer reported that their points from the last three transactions haven’t been credited to their account.',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              _buildActionChip('Assign'),
              SizedBox(width: 12.w),
              _buildActionChip('Resolve', isPrimary: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label, {bool isPrimary = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: isPrimary ? AppColors.onPrimary : AppColors.boneWhite,
        ),
      ),
    );
  }
}
