import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('JOIN THE CLUB', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
            SizedBox(height: 8.h),
            Text('Create Account', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp, fontWeight: FontWeight.w700)),
            Text('Start your journey with premium coffee', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Full Name', hint: 'Alex Johnson'),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 48.h),
            AppButton(
              text: 'CREATE ACCOUNT',
              onPressed: () => context.goNamed('home'),
            ),
            SizedBox(height: 32.h),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline),
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: AppTypography.labelMedium(context).copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
