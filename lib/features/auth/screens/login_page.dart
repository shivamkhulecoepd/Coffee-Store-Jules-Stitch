import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String role = (GoRouterState.of(context).extra as String?) ?? 'Customer';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _navigateToRoleHome(context, role),
            child: Text('SKIP', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary)),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ACCESS GRANTED', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 8.h),
            Text('Welcome Back', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
            Text('Sign in as $role to continue', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => context.pushNamed('forgot-password'),
                child: Text('Forgot Password?', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 0)),
              ),
            ),
            SizedBox(height: 48.h),
            AppButton(
              text: 'SIGN IN',
              onPressed: () => _navigateToRoleHome(context, role),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
                GestureDetector(
                  onTap: () => context.pushNamed('register'),
                  child: Text("Register", style: AppTypography.labelMedium(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRoleHome(BuildContext context, String role) {
    if (role == 'Barista') {
      context.goNamed('barista');
    } else if (role == 'Admin') {
      context.goNamed('admin');
    } else {
      context.goNamed('home');
    }
  }
}
