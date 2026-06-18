import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/custom_button.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Task Detail', style: AppTypography.headlineMedium),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Machine Care', style: AppTypography.labelSmall.copyWith(color: AppColors.primary)),
                  SizedBox(height: 8.h),
                  Text('Daily Espresso Machine Backflush', style: AppTypography.headlineMedium),
                  SizedBox(height: 16.h),
                  Text(
                    'Ensure the group heads are cleaned with the specialized brush and the blind filter is used with cleaning powder.',
                    style: AppTypography.bodyMedium.copyWith(color: AppColors.outline),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _buildChecklist('Remove Portafilters'),
            _buildChecklist('Insert Blind Filter'),
            _buildChecklist('Add Cleaning Powder'),
            _buildChecklist('Run Backflush Cycle (x5)'),
            const Spacer(),
            AppButton(text: 'Mark as Completed', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklist(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank, color: AppColors.outline),
          SizedBox(width: 16.w),
          Text(text, style: AppTypography.labelMedium),
        ],
      ),
    );
  }
}
