import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(24.w),
            children: [
              _buildPlanCard(context, 'CORE', r'.99/mo', ['5 specialty cups', '10% off whole beans', 'Member rewards access'], state.subscriptionPlan == 'CORE'),
              SizedBox(height: 24.h),
              _buildPlanCard(context, 'PROFESSIONAL', r'9.99/mo', ['15 specialty cups', '20% off whole beans', 'Exclusive tasting events'], state.subscriptionPlan == 'PROFESSIONAL', isPopular: true),
              SizedBox(height: 24.h),
              _buildPlanCard(context, 'ELITE', r'4.99/mo', ['Unlimited selections', '30% off whole beans', 'VIP sequence priority'], state.subscriptionPlan == 'ELITE'),
              SizedBox(height: 120.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, String name, String price, List<String> features, bool isCurrent, {bool isPopular = false}) {
    return AppGlassContainer(
      padding: EdgeInsets.all(32.w),
      boxShadow: (isPopular || isCurrent) ? AppTheme.premiumShadow : null,
      opacity: isCurrent ? 1.0 : (isPopular ? 0.9 : 0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
              if (isCurrent)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(color: AppColors.success, borderRadius: BorderRadius.circular(12.r)),
                  child: Text('ACTIVE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.background, fontSize: 10.sp, fontWeight: FontWeight.w800)),
                )
              else if (isPopular)
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
          AppButton(
            text: isCurrent ? 'MANAGE PLAN' : 'SELECT PLAN',
            onPressed: isCurrent ? () {} : () => context.read<UserBloc>().add(UpdateSubscriptionEvent(name)),
          ),
        ],
      ),
    );
  }
}
