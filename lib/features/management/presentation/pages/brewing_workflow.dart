import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class BrewingWorkflow extends StatelessWidget {
  const BrewingWorkflow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Brewing Order #421', style: AppTypography.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('EXTRACTION TIMER', style: AppTypography.labelSmall.copyWith(color: AppColors.outline)),
                  SizedBox(height: 16.h),
                  Text('00:24', style: AppTypography.displayLarge),
                  SizedBox(height: 16.h),
                  LinearProgressIndicator(
                    value: 0.8,
                    backgroundColor: AppColors.surfaceSecondary,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildStep('1. Grinding Beans', true),
            _buildStep('2. Tamping', true),
            _buildStep('3. Extraction', false),
            _buildStep('4. Milk Texturing', false),
            const Spacer(),
            AppButton(text: 'Complete Brew', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String label, bool isDone) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.circle_outlined,
            color: isDone ? Colors.green : AppColors.outline,
          ),
          SizedBox(width: 16.w),
          Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isDone ? AppColors.boneWhite : AppColors.outline,
              decoration: isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
