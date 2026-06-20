import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Premium Tiers', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildPlanCard(context, 'CORE', r'9.99/mo', ['5 specialty cups', '10% off whole beans', 'Member rewards access']),
          SizedBox(height: 24.h),
          _buildPlanCard(context, 'PROFESSIONAL', r'9.99/mo', ['15 specialty cups', '20% off whole beans', 'Exclusive tasting events', 'Complimentary delivery'], isPopular: true),
          SizedBox(height: 24.h),
          _buildPlanCard(context, 'ELITE', r'9.99/mo', ['Unlimited selections', '30% off whole beans', 'VIP sequence priority', 'Dedicated concierge']),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String name, String price, List<String> features, {bool isPopular = false}) {
    return AppGlassContainer(
      padding: EdgeInsets.all(32.w),
      boxShadow: isPopular ? AppTheme.premiumShadow : null,
      opacity: isPopular ? 0.9 : 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
              if (isPopular)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12.r)),
                  child: Text('PREMIUM CHOICE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.onPrimary, fontSize: 10.sp, fontWeight: FontWeight.w800)),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(price, style: AppTypography.displayLarge(context).copyWith(fontSize: 36.sp)),
          SizedBox(height: 32.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              children: [
                Icon(Icons.check_circle_outline, size: 18.sp, color: AppColors.primary),
                SizedBox(width: 16.w),
                Expanded(child: Text(f, style: AppTypography.bodyMedium(context).copyWith(color: AppColors.boneWhite.withValues(alpha: 0.8)))),
              ],
            ),
          )),
          SizedBox(height: 32.h),
          AppButton(text: 'SELECT PLAN', onPressed: () {}),
        ],
      ),
    );
  }
}
