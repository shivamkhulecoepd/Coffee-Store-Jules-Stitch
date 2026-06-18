import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Coffee Subscription', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildPlanCard('Basic', r'9.99/mo', ['5 cups per month', '10% off beans', 'Member rewards']),
          SizedBox(height: 24.h),
          _buildPlanCard('Pro', r'9.99/mo', ['15 cups per month', '20% off beans', 'Exclusive tastings', 'Free delivery'], isPopular: true),
          SizedBox(height: 24.h),
          _buildPlanCard('Elite', r'9.99/mo', ['Unlimited cups', '30% off beans', 'VIP events', 'Free delivery']),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String name, String price, List<String> features, {bool isPopular = false}) {
    return AppGlassContainer(
      padding: EdgeInsets.all(24.w),
      opacity: isPopular ? 0.2 : 0.1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(12.r)),
                child: Text('POPULAR', style: AppTypography.labelSmall.copyWith(color: AppColors.onPrimary, fontSize: 10.sp)),
              ),
            ),
          Text(name, style: AppTypography.headlineMedium),
          Text(price, style: AppTypography.displayLargeMobile.copyWith(color: AppColors.primary)),
          SizedBox(height: 24.h),
          ...features.map((f) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(children: [Icon(Icons.check, size: 16.sp, color: AppColors.primary), SizedBox(width: 12.w), Text(f, style: AppTypography.bodyMedium)]),
          )),
          SizedBox(height: 24.h),
          AppButton(text: 'Select Plan', onPressed: () {}),
        ],
      ),
    );
  }
}
