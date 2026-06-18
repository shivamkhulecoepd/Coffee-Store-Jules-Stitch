import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48.h),
              Text('Choose Your Role', style: AppTypography.displayLargeMobile),
              Text('Select how you want to experience Bean & Brew', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
              SizedBox(height: 48.h),
              _buildRoleCard(context, 'Customer', 'Browse menu and order coffee', Icons.person_outline, '/login'),
              SizedBox(height: 24.h),
              _buildRoleCard(context, 'Barista', 'Manage orders and brew operations', Icons.coffee_maker_outlined, '/login'),
              SizedBox(height: 24.h),
              _buildRoleCard(context, 'Admin', 'View analytics and manage store', Icons.admin_panel_settings_outlined, '/login'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route, arguments: title),
      child: AppGlassContainer(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.headlineMedium),
                  Text(subtitle, style: AppTypography.bodyMedium.copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
