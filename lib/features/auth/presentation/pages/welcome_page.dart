import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: AppColors.background),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.background.withValues(alpha: 0.8),
                  AppColors.background,
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
                    Text('Experience the Art of Coffee', style: AppTypography.displayLargeMobile),
                    SizedBox(height: 16.h),
                    Text(
                      'Join Bean & Brew and discover a world of artisanal flavors and premium brewing tools.',
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
                    ),
                    SizedBox(height: 48.h),
                    AppButton(
                      text: 'Get Started',
                      onPressed: () => Navigator.pushNamed(context, '/role'),
                    ),
                    SizedBox(height: 16.h),
                    AppButton(
                      text: 'Login',
                      isPrimary: false,
                      onPressed: () => Navigator.pushNamed(context, '/role'),
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
