import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

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
                height: 140.h,
                width: 140.h,
                borderRadius: 70.r,
                shape: BoxShape.circle,
                boxShadow: AppTheme.premiumShadow,
                child: Center(child: Icon(Icons.send_rounded, size: 56.sp, color: AppColors.primary)),
              ),
              SizedBox(height: 48.h),
              Text('REQUEST SENT', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 3)),
              SizedBox(height: 8.h),
              Text('Order Transmitted', style: AppTypography.displayLargeMobile(context)),
              SizedBox(height: 16.h),
              Text(
                'Your sequence has been received by the station. We will notify you once extraction begins.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.5),
              ),
              SizedBox(height: 80.h),
              AppButton(
                text: 'Track Progress',
                onPressed: () => context.pushReplacementNamed('confirmed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
