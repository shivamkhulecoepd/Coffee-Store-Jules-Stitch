import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Membership', style: AppTypography.headlineMedium(context)),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                AppGlassContainer(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 54.r,
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 54.sp,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        state.name,
                        style: AppTypography.headlineLarge(
                          context,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        state.email,
                        style: AppTypography.bodyMedium(
                          context,
                        ).copyWith(color: AppColors.outline),
                      ),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${state.points} PTS • ${state.tier} Tier',
                          style: AppTypography.labelSmall(context).copyWith(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                _buildProfileOption(
                  context,
                  Icons.history,
                  'Order History',
                  'history',
                ),
                _buildProfileOption(
                  context,
                  Icons.favorite_border,
                  'Wishlist',
                  'wishlist',
                ),
                _buildProfileOption(
                  context,
                  Icons.location_on_outlined,
                  'Destinations',
                  'address',
                ),
                _buildProfileOption(
                  context,
                  Icons.credit_card,
                  'Payment Methods',
                  'payment',
                ),
                _buildProfileOption(
                  context,
                  Icons.card_membership,
                  'Subscription',
                  'subscription',
                ),
                _buildProfileOption(
                  context,
                  Icons.settings_outlined,
                  'Preferences',
                  'settings',
                ),
                const Divider(color: Colors.white10, height: 48),
                SafeArea(
                  child: _buildProfileOption(
                    context,
                    Icons.logout,
                    'Logout Session',
                    'welcome',
                    isDestructive: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    String routeName, {
    bool isDestructive = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: ListTile(
          onTap: () {
            if (routeName == 'welcome') {
              context.goNamed(routeName);
            } else {
              context.pushNamed(routeName);
            }
          },
          leading: Icon(
            icon,
            color: isDestructive ? AppColors.error : AppColors.primary,
            size: 24.sp,
          ),
          title: Text(
            title,
            style: AppTypography.labelMedium(
              context,
            ).copyWith(color: isDestructive ? AppColors.error : Colors.white),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.outline,
            size: 14.sp,
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
