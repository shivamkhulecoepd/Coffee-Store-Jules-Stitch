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
                child: Center(
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check_circle_outline_rounded, size: 60.sp, color: AppColors.success),
                  ),
                ),
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
              SizedBox(height: 32.h),
              AppGlassContainer(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                borderRadius: 20.r,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined, color: AppColors.primary, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('ESTIMATED: 04:00', style: AppTypography.dataMono(context).copyWith(fontSize: 12.sp, color: AppColors.primary)),
                  ],
                ),
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
