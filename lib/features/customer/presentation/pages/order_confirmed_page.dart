import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(40.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle, size: 100.sp, color: AppColors.primary),
            ),
            SizedBox(height: 48.h),
            Text('Order Confirmed!', style: AppTypography.displayLargeMobile),
            SizedBox(height: 16.h),
            Text(
              'Your delicious coffee is being prepared by our baristas and will be ready shortly.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
            ),
            SizedBox(height: 64.h),
            AppButton(
              text: 'Track Order',
              onPressed: () {},
            ),
            SizedBox(height: 16.h),
            AppButton(
              text: 'Back to Home',
              isPrimary: false,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
