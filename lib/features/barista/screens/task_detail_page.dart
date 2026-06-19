import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Protocol Detail', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGlassContainer(
              padding: EdgeInsets.all(28.w),
              boxShadow: AppTheme.premiumShadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MAINTENANCE PROTOCOL', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 2)),
                  SizedBox(height: 12.h),
                  Text('Daily Espresso Machine Backflush', style: AppTypography.headlineMedium(context)),
                  SizedBox(height: 20.h),
                  Text(
                    'Ensure the group heads are cleaned with the specialized nylon brush and the blind filter is used with 3g of cleaning powder.',
                    style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Text('CHECKLIST', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
            SizedBox(height: 16.h),
            _buildChecklist(context, 'Remove Portafilters & Baskets'),
            _buildChecklist(context, 'Insert Blind Filter with Powder'),
            _buildChecklist(context, 'Run Automatic Backflush Cycle (5 Cycles)'),
            _buildChecklist(context, 'Scrub Group Gaskets'),
            const Spacer(),
            AppButton(text: 'COMPLETE PROTOCOL', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklist(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.white10),
            ),
            child: Icon(Icons.check_box_outline_blank, color: AppColors.outline, size: 18.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(child: Text(text, style: AppTypography.labelMedium(context))),
        ],
      ),
    );
  }
}
