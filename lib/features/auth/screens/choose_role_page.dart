import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class ChooseRolePage extends StatelessWidget {
  const ChooseRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text('Identify Your\nPerspective', style: AppTypography.displayLargeMobile(context)),
            SizedBox(height: 12.h),
            Text('Select your primary interface to continue.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.textSecondary)),
            SizedBox(height: 48.h),
            _buildRoleCard(
              context,
              'Customer',
              'Order, track, and earn rewards seamlessly.',
              Icons.person_outline,
              'home',
            ),
            SizedBox(height: 20.h),
            _buildRoleCard(
              context,
              'Barista',
              'Manage brews, tables, and station tasks.',
              Icons.coffee_maker_outlined,
              'barista',
            ),
            SizedBox(height: 20.h),
            _buildRoleCard(
              context,
              'Administrator',
              'Full stack inventory and store analytics.',
              Icons.admin_panel_settings_outlined,
              'admin',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(SelectRoleEvent(title));
        context.pushNamed('login', extra: {'role': title, 'route': route});
      },
      child: AppGlassContainer(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 28.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleLarge(context).copyWith(fontWeight: FontWeight.w700)),
                  SizedBox(height: 4.h),
                  Text(subtitle, style: AppTypography.bodySmall(context)),
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
