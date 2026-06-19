import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String role = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'Customer';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _navigateToRoleHome(context, role),
            child: Text('Skip', style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back', style: AppTypography.displayLargeMobile),
            Text('Sign in as $role to continue', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                child: Text('Forgot Password?', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
              ),
            ),
            SizedBox(height: 48.h),
            AppButton(
              text: 'Sign In',
              onPressed: () => _navigateToRoleHome(context, role),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Text("Register", style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
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
      Navigator.pushReplacementNamed(context, '/barista');
    } else if (role == 'Admin') {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
