import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Password', style: AppTypography.displayLargeMobile),
            Text('Set your new secure password', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            const AppTextField(label: 'New Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 24.h),
            const AppTextField(label: 'Confirm Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 48.h),
            AppButton(text: 'Reset Password', onPressed: () => Navigator.pushReplacementNamed(context, '/login')),
          ],
        ),
      ),
    );
  }
}
