import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/shot_timer.dart';

class BrewingWorkflow extends StatelessWidget {
  const BrewingWorkflow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Brewing Order #421', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(32.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('EXTRACTION PROGRESS', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                  SizedBox(height: 24.h),
                  const ShotTimer(progress: 0.75, time: '24'),
                  SizedBox(height: 24.h),
                  Text('Flow Rate: 1.2g/s', style: AppTypography.dataMono(context).copyWith(color: AppColors.outline, fontSize: 12.sp)),
                ],
              ),
            ),
            SizedBox(height: 48.h),
            _buildStep(context, '1. Grinding Arabica Beans', true),
            _buildStep(context, '2. Precision Tamping', true),
            _buildStep(context, '3. Extraction Phase', false),
            _buildStep(context, '4. Micro-foam Texturing', false),
            SizedBox(height: 48.h),
            AppButton(text: 'Complete Sequence', onPressed: () => Navigator.pop(context)),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String label, bool isDone) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_off,
            color: isDone ? AppColors.primary : AppColors.outline.withValues(alpha: 0.3),
            size: 24.sp,
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              label,
              style: AppTypography.labelMedium(context).copyWith(
                color: isDone ? AppColors.boneWhite : AppColors.outline,
                decoration: isDone ? TextDecoration.lineThrough : null,
                fontWeight: isDone ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
