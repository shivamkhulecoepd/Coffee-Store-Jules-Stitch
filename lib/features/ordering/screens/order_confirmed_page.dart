import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class OrderConfirmedPage extends StatelessWidget {
  const OrderConfirmedPage({super.key});

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
                height: 160.h,
                width: 160.h,
                borderRadius: 80.r,
                shape: BoxShape.circle,
                boxShadow: AppTheme.premiumShadow,
                child: Center(child: Icon(Icons.check_circle_outline_rounded, size: 80.sp, color: AppColors.success)),
              ),
              SizedBox(height: 48.h),
              Text('SEQUENCE VERIFIED', style: AppTypography.labelSmall(context).copyWith(color: AppColors.success, letterSpacing: 3)),
              SizedBox(height: 12.h),
              Text('Order Confirmed!', style: AppTypography.displayLargeMobile(context).copyWith(fontSize: 36.sp)),
              SizedBox(height: 16.h),
              Text(
                'Your artisanal brew is being prepared with precision. Extraction will be complete in approximately 4 minutes.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.6),
              ),
              SizedBox(height: 80.h),
              AppButton(
                text: 'RETURN TO HOME',
                onPressed: () => context.goNamed('home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
