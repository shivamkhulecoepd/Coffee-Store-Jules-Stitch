import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.backgroundDark),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.backgroundDark.withOpacity(0.8),
                  AppColors.backgroundDark,
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(32.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: ScreenUtil().screenHeight - 100.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('LUXURY MODERN', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 4)),
                    SizedBox(height: 8.h),
                    Text('Artisanal Coffee\nExperience', style: AppTypography.displayLarge(context).copyWith(fontSize: 42.sp)),
                    SizedBox(height: 24.h),
                    Text(
                      'Precision brewing meets sophisticated design. Experience the future of coffee management.',
                      style: AppTypography.bodyLarge(context).copyWith(color: AppColors.outline, height: 1.5),
                    ),
                    SizedBox(height: 64.h),
                    AppButton(
                      text: 'GET STARTED',
                      onPressed: () => context.pushNamed('role'),
                    ),
                    SizedBox(height: 20.h),
                    AppButton(
                      text: 'LOGIN',
                      isPrimary: false,
                      onPressed: () => context.pushNamed('role'),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
