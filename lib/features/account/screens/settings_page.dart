import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pushEnabled = true;
  bool locationEnabled = false;
  bool biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Preferences', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildSectionHeader('Notifications'),
          _buildToggleItem('Push Notifications', 'Real-time order updates', pushEnabled, (val) => setState(() => pushEnabled = val)),
          _buildToggleItem('Marketing Offers', 'Exclusive deals and rewards', false, (val) {}),
          SizedBox(height: 32.h),
          _buildSectionHeader('Security'),
          _buildToggleItem('Biometric Login', 'Use FaceID or Fingerprint', biometricEnabled, (val) => setState(() => biometricEnabled = val)),
          _buildActionItem('Change Password', 'Update your secure key', Icons.lock_outline),
          SizedBox(height: 32.h),
          _buildSectionHeader('Account'),
          _buildToggleItem('Location Access', 'Find nearest brewing stations', locationEnabled, (val) => setState(() => locationEnabled = val)),
          _buildActionItem('Data & Privacy', 'Manage your information', Icons.privacy_tip_outlined),
          _buildActionItem('Delete Account', 'Permanently remove profile', Icons.delete_forever_outlined, isDestructive: true),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
      child: Text(title, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
    );
  }

  Widget _buildToggleItem(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: AppTypography.bodySmall(context).copyWith(fontSize: 11.sp)),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(String title, String subtitle, IconData icon, {bool isDestructive = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? AppColors.error : AppColors.outline, size: 22.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700, color: isDestructive ? AppColors.error : Colors.white)),
                  Text(subtitle, style: AppTypography.bodySmall(context).copyWith(fontSize: 11.sp)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
          ],
        ),
      ),
    );
  }
}
