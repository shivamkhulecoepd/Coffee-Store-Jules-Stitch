import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Reward Ledger', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                AppGlassContainer(
                  height: 220.h,
                  padding: EdgeInsets.all(32.w),
                  boxShadow: AppTheme.premiumShadow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ACCUMULATED CREDITS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
                      SizedBox(height: 12.h),
                      Text('${state.points}', style: AppTypography.displayLarge(context).copyWith(fontSize: 56.sp, color: AppColors.primary)),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20.r)),
                        child: Text('${state.tier} Tier Member', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                _buildSectionHeader(context, 'AVAILABLE REDEMPTIONS'),
                SizedBox(height: 20.h),
                _buildRewardItem(context, 'Artisan Espresso', 500, state.points),
                _buildRewardItem(context, 'Seasonal Pastry', 800, state.points),
                _buildRewardItem(context, 'Limited Edition Mug', 2500, state.points),
                SizedBox(height: 120.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, letterSpacing: 1.5)),
    );
  }

  Widget _buildRewardItem(BuildContext context, String title, int cost, int currentPoints) {
    final bool canRedeem = currentPoints >= cost;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        opacity: canRedeem ? 0.8 : 0.4,
        child: InkWell(
          onTap: canRedeem ? () => context.read<UserBloc>().add(RedeemPointsEvent(cost)) : null,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.card_giftcard, color: AppColors.primary, size: 24.sp),
              ),
              SizedBox(width: 20.w),
              Expanded(child: Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w600))),
              Text('$cost PTS', style: AppTypography.dataMono(context).copyWith(color: AppColors.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
