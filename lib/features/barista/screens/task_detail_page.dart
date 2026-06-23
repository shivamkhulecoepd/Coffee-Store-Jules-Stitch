import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/custom_button.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';

class TaskDetailPage extends StatelessWidget {
  final Map<String, dynamic>? data;

  const TaskDetailPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final String title = data?['title'] ?? 'Maintenance Protocol';

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
      body: SingleChildScrollView(
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
                  Text(title, style: AppTypography.headlineMedium(context)),
                  SizedBox(height: 20.h),
                  Text(
                    'Ensure the equipment and area are synchronized with the cloud session and all procedural steps are followed for quality assurance.',
                    style: AppTypography.bodyMedium(context).copyWith(color: AppColors.outline, height: 1.6),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Text('CHECKLIST', style: AppTypography.labelSmall(context).copyWith(color: AppColors.primary, letterSpacing: 1.5)),
            SizedBox(height: 16.h),
            _buildChecklist(context, 'Initial Equipment Inspection'),
            _buildChecklist(context, 'Execution of Protocol Phase A'),
            _buildChecklist(context, 'Quality Control Verification'),
            _buildChecklist(context, 'Digital Log Submission'),
            SizedBox(height: 40.h),
            AppButton(
              text: 'COMPLETE PROTOCOL',
              onPressed: () {
                context.read<BaristaBloc>().add(CompleteTaskEvent(title));
                context.pop();
              },
            ),
            SizedBox(height: 40.h),
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
