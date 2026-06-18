import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ActiveTablesBillingPage extends StatelessWidget {
  const ActiveTablesBillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Active Tables & Billing', style: AppTypography.headlineMedium),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildBillingItem(index + 1);
        },
      ),
    );
  }

  Widget _buildBillingItem(int tableNum) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Table '+tableNum.toString(), style: AppTypography.labelMedium),
              Text('34m active', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unpaid Amount', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
              Text(r'8.50', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn('Print Bill', Icons.print_outlined),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionBtn('Checkout', Icons.credit_card_outlined, isPrimary: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, IconData icon, {bool isPrimary = false}) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16.sp, color: isPrimary ? AppColors.onPrimary : AppColors.boneWhite),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: isPrimary ? AppColors.onPrimary : AppColors.boneWhite,
            ),
          ),
        ],
      ),
    );
  }
}
