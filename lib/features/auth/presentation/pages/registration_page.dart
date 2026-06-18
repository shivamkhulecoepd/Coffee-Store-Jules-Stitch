import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Account', style: AppTypography.displayLargeMobile),
            Text('Join our coffee community today', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 32.h),
            const AppTextField(label: 'Full Name', hint: 'Alex Johnson'),
            SizedBox(height: 20.h),
            const AppTextField(label: 'Email Address', hint: 'alex@example.com'),
            SizedBox(height: 20.h),
            const AppTextField(label: 'Password', hint: '••••••••', isPassword: true),
            SizedBox(height: 40.h),
            AppButton(text: 'Sign Up', onPressed: () => Navigator.pushReplacementNamed(context, '/home')),
          ],
        ),
      ),
    );
  }
}
