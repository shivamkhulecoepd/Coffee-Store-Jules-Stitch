import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';

class OperationalTasksPage extends StatelessWidget {
  const OperationalTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Duty Roster', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: EdgeInsets.all(24.w),
        children: [
          _buildTaskItem(context, 'Daily Machine Backflush', 'URGENT', AppColors.primary),
          _buildTaskItem(context, 'Grinder Calibration', 'PENDING', AppColors.outline),
          _buildTaskItem(context, 'Inventory Log: Dairy', 'COMPLETED', AppColors.success),
          _buildTaskItem(context, 'Restock Pastry Case', 'PENDING', AppColors.outline),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, String status, Color statusColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: AppGlassContainer(
        padding: EdgeInsets.all(20.w),
        child: ListTile(
          onTap: () => context.pushNamed('task-detail'),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment_outlined, color: statusColor, size: 24.sp),
          ),
          title: Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
          subtitle: Text(status, style: AppTypography.labelSmall(context).copyWith(color: statusColor, letterSpacing: 1.5, fontSize: 10.sp)),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
