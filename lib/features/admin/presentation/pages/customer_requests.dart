import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/glass_container.dart';

class CustomerRequestsPage extends StatelessWidget {
  const CustomerRequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Service Queue', style: AppTypography.headlineMedium),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          return _buildRequestItem();
        },
      ),
    );
  }

  Widget _buildRequestItem() {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      boxShadow: AppTheme.premiumShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('SUPPORT ID #REQ-982', style: AppTypography.dataMono.copyWith(color: AppColors.primary, fontSize: 10.sp)),
              Text('2h AGO', style: AppTypography.labelSmall.copyWith(color: AppColors.outline, fontSize: 10.sp)),
            ],
          ),
          SizedBox(height: 16.h),
          Text('Loyalty Credits Discrepancy', style: AppTypography.labelMedium.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 8.h),
          Text(
            'Customer reports that previous 3 transactions haven\'t synchronized with the reward ledger. Requested manual audit.',
            style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, height: 1.5, fontSize: 13.sp),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              _buildActionChip('ASSIGN AGENT'),
              SizedBox(width: 16.w),
              _buildActionChip('RESOLVE CASE', isPrimary: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label, {bool isPrimary = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(8.r),
        border: isPrimary ? null : Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: AppTypography.labelSmall.copyWith(
          color: isPrimary ? AppColors.onPrimary : AppColors.boneWhite,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
