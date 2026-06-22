import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

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
              Text('SELECT INTERFACE', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
              Text('Welcome Back', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
              Text('Choose your specialized workspace', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
              SizedBox(height: 64.h),
              _buildRoleCard(context, 'Customer', 'Browse collections and place orders', Icons.person_outline, 'login'),
              SizedBox(height: 24.h),
              _buildRoleCard(context, 'Barista', 'System control and brewing workflow', Icons.coffee_maker_outlined, 'login'),
              SizedBox(height: 24.h),
              _buildRoleCard(context, 'Admin', 'Executive metrics and store management', Icons.admin_panel_settings_outlined, 'login'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, String routeName) {
    return GestureDetector(
      onTap: () => context.pushNamed(routeName, extra: title),
      behavior: HitTestBehavior.opaque,
      child: AppGlassContainer(
        padding: EdgeInsets.all(24.w),
        boxShadow: AppTheme.premiumShadow,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 32.sp),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.headlineMedium(context).copyWith(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
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
