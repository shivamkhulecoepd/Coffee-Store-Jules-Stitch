import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/glass_container.dart';

class OperationalTasksPage extends StatelessWidget {
  const OperationalTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Operational Tasks', style: AppTypography.headlineMedium),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          _buildTaskItem('Daily Machine Cleaning', 'Pending', AppColors.primary),
          _buildTaskItem('Inventory Check', 'Completed', Colors.green),
          _buildTaskItem('Staff Meeting', '14:00 PM', AppColors.outline),
          _buildTaskItem('Restock Pastry Display', 'Pending', AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.assignment_outlined, color: statusColor),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium),
                  Text(status, style: AppTypography.labelSmall.copyWith(color: statusColor)),
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right, color: AppColors.outline),
          ],
        ),
      ),
    );
  }
}
