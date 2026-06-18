import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class OrderTransmittedPage extends StatelessWidget {
  const OrderTransmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppGlassContainer(
                height: 120.h,
                width: 120.h,
                borderRadius: 60.r,
                child: Icon(Icons.send_rounded, size: 50.sp, color: AppColors.primary),
              ),
              SizedBox(height: 48.h),
              Text('Order Transmitted', style: AppTypography.headlineLarge),
              SizedBox(height: 16.h),
              Text(
                'Your order has been sent to our barista system and is awaiting confirmation.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
              ),
              SizedBox(height: 64.h),
              AppButton(
                text: 'View Status',
                onPressed: () => Navigator.pushReplacementNamed(context, '/confirmed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
