import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_animations.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../customer/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome Back', style: AppTypography.displayLargeMobile),
            Text('Sign in to continue your coffee journey', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Forgot Password?', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
            ),
            SizedBox(height: 48.h),
            AppButton(
              text: 'Sign In',
              onPressed: () => Navigator.pushReplacement(context, AppAnimations.fadePageRoute(const HomePage())),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? ", style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
                Text("Register", style: AppTypography.labelMedium.copyWith(color: AppColors.primary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
