import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

class ShiftOverviewPage extends StatelessWidget {
  const ShiftOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Shift Analytics', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(28.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                children: [
                  _buildShiftDetail(context, 'CURRENT WINDOW', 'Morning (06:00 - 14:00)'),
                  const Divider(color: Colors.white10, height: 32),
                  _buildShiftDetail(context, 'ACTIVE PERSONNEL', 'Sarah, Alex, Michael'),
                  const Divider(color: Colors.white10, height: 32),
                  _buildShiftDetail(context, 'STATION REVENUE', r',240.50'),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            _buildSectionHeader(context, 'STATION ANNOUNCEMENTS'),
            SizedBox(height: 16.h),
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Text(
                'SYSTEM ALERT: New seasonal blend "Autumn Harvest" deployment begins at 04:00 tomorrow. Verify all grinder settings.',
                style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
    );
  }

  Widget _buildShiftDetail(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, fontSize: 10.sp)),
        Text(value, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
