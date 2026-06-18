import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forgot Password', style: AppTypography.displayLargeMobile),
            SizedBox(height: 8.h),
            Text('Enter your email to receive a reset code', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 48.h),
            AppButton(text: 'Send Code', onPressed: () => Navigator.pushNamed(context, '/otp')),
          ],
        ),
      ),
    );
  }
}
