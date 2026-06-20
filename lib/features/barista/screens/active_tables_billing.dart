import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

class ActiveTablesBillingPage extends StatelessWidget {
  const ActiveTablesBillingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Active Sessions', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 4,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildBillingItem(context, index + 1);
        },
      ),
    );
  }

  Widget _buildBillingItem(BuildContext context, int tableNum) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      boxShadow: AppTheme.premiumShadow,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('TABLE $tableNum', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
              Text('34m ACTIVE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Unpaid Amount', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.boneWhite.withOpacity(0.7))),
              Text(r'8.50', style: AppTypography.headlineMedium(context).copyWith(color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(context, 'Print Receipt', Icons.print_outlined),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildActionBtn(context, 'Checkout', Icons.credit_card_outlined, isPrimary: true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(BuildContext context, String label, IconData icon, {bool isPrimary = false}) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
        border: isPrimary ? null : Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.sp, color: isPrimary ? AppColors.onPrimary : AppColors.primary),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTypography.labelSmall(context).copyWith(
              color: isPrimary ? AppColors.onPrimary : AppColors.primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
