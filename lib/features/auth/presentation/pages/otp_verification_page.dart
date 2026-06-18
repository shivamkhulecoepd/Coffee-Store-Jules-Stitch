import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Verification', style: AppTypography.displayLargeMobile),
            Text('Enter the 4-digit code sent to your email', style: AppTypography.bodyMedium.copyWith(color: AppColors.outline)),
            SizedBox(height: 48.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _buildOTPField()),
            ),
            SizedBox(height: 48.h),
            AppButton(text: 'Verify', onPressed: () => Navigator.pushNamed(context, '/reset-password')),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPField() {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: const Center(child: TextField(textAlign: TextAlign.center, style: TextStyle(fontSize: 24, color: Colors.white), decoration: InputDecoration(border: InputBorder.none))),
    );
  }
}
