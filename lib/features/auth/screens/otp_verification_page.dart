import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';

class OTPVerificationPage extends StatelessWidget {
  const OTPVerificationPage({super.key});

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
            Text('SECURITY CHECK', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
            SizedBox(height: 8.h),
            Text('Verification', style: AppTypography.displayLargeMobile(context).copyWith(fontWeight: FontWeight.w700)),
            Text('Enter the 4-digit code sent to your primary email.', style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline)),
            SizedBox(height: 64.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) => _buildOTPField(context)),
            ),
            SizedBox(height: 64.h),
            AppButton(
              text: 'VERIFY CODE',
              onPressed: () => context.pushNamed('reset-password'),
            ),
            SizedBox(height: 32.h),
            Center(
              child: Text(
                'Resend code in 00:59',
                style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPField(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.outline.withOpacity(0.2)),
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: AppTypography.headlineLarge(context).copyWith(color: AppColors.primary),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}
