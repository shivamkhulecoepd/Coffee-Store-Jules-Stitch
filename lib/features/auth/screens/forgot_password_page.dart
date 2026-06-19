import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textfield.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RECOVER ACCOUNT', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 8.h),
            Text('Forgot Password', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 16.h),
            Text('Enter your email to receive a secure recovery code.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 48.h),
            AppButton(
              text: 'SEND RESET CODE',
              onPressed: () => context.pushNamed('otp'),
            ),
          ],
        ),
      ),
    );
  }
}
