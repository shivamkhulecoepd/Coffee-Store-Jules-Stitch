import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Profile', style: AppTypography.headlineMedium),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.surfaceSecondary,
              child: Icon(Icons.person, size: 50.sp, color: AppColors.primary),
            ),
            SizedBox(height: 16.h),
            Text('Alex Johnson', style: AppTypography.headlineMedium),
            Text('alex.j@example.com', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 32.h),
            _buildProfileOption(context, Icons.history, 'Order History', '/history'),
            _buildProfileOption(context, Icons.favorite_border, 'Wishlist', '/wishlist'),
            _buildProfileOption(context, Icons.credit_card, 'Payment Methods', '/payment'),
            _buildProfileOption(context, Icons.card_giftcard, 'Rewards', '/rewards'),
            _buildProfileOption(context, Icons.subscriptions_outlined, 'Subscription', '/subscription'),
            const Divider(color: AppColors.surfaceSecondary, height: 40),
            _buildProfileOption(context, Icons.logout, 'Logout', '/welcome', isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title, String route, {bool isDestructive = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: ListTile(
          onTap: () {
            if (route == '/welcome') {
               Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
            } else {
               Navigator.pushNamed(context, route);
            }
          },
          leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.primary),
          title: Text(title, style: AppTypography.labelMedium.copyWith(color: isDestructive ? Colors.red : Colors.white)),
          trailing: Icon(Icons.keyboard_arrow_right, color: AppColors.outline),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
