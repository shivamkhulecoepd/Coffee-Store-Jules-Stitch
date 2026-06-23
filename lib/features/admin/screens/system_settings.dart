import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('System Config', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildSettingItem(context, 'Station Synchronization', 'Automatic (30s intervals)', true),
          _buildSettingItem(context, 'Cloud Ledger Logging', 'Active', true),
          _buildSettingItem(context, 'Thermal Print Receipts', 'Disabled', false),
          _buildSettingItem(context, 'Barista Auth Mode', 'Biometric', true),
        ],
      ),
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, String value, bool enabled) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                Text(value, style: AppTypography.bodySmall(context)),
              ],
            ),
            Switch(
              value: enabled,
              onChanged: (val) {},
              activeColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
