import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_container.dart';
import '../bloc/barista_bloc.dart';
import '../bloc/barista_event.dart';
import '../bloc/barista_state.dart';

class OperationalTasksPage extends StatefulWidget {
  const OperationalTasksPage({super.key});

  @override
  State<OperationalTasksPage> createState() => _OperationalTasksPageState();
}

class _OperationalTasksPageState extends State<OperationalTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<BaristaBloc>().add(LoadBaristaDataEvent());
  }

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
      body: BlocBuilder<BaristaBloc, BaristaState>(
        builder: (context, state) {
          return ListView.separated(
            padding: EdgeInsets.all(24.w),
            itemCount: state.tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              Color statusColor = AppColors.outline;
              if (task['color'] == 'primary') statusColor = AppColors.primary;
              if (task['color'] == 'success') statusColor = AppColors.success;

              return _buildTaskItem(context, task['title'], task['status'], statusColor);
            },
          );
        },
      ),
    );
  }

  Widget _buildTaskItem(BuildContext context, String title, String status, Color statusColor) {
    return AppGlassContainer(
      padding: EdgeInsets.all(20.w),
      child: ListTile(
        onTap: () => context.pushNamed('task-detail', extra: {'title': title}),
        leading: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.assignment_outlined, color: statusColor, size: 24.sp),
        ),
        title: Text(title, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
        subtitle: Text(status, style: AppTypography.labelSmall(context).copyWith(color: statusColor, letterSpacing: 1.5, fontSize: 10.sp)),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.outline, size: 14.sp),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
