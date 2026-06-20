import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 54.r,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(Icons.person, size: 54.sp, color: AppColors.primary),
                  ),
                  SizedBox(height: 20.h),
                  Text('Alex Johnson', style: AppTypography.headlineLarge(context).copyWith(fontWeight: FontWeight.w700)),
                  Text('alex.j@example.com', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildProfileOption(context, Icons.history, 'Order History', 'history'),
            _buildProfileOption(context, Icons.favorite_border, 'Wishlist', 'wishlist'),
            _buildProfileOption(context, Icons.credit_card, 'Payment Methods', 'payment'),
            const Divider(color: Colors.white10, height: 48),
            _buildProfileOption(context, Icons.logout, 'Logout Session', 'welcome', isDestructive: true),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title, String routeName, {bool isDestructive = false}) {
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
          leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary, size: 24.sp),
          title: Text(title, style: AppTypography.labelMedium(context).copyWith(color: isDestructive ? AppColors.error : Colors.white)),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
