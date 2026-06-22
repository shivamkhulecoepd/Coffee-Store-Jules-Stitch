import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../data/repositories/store_repository.dart';
import '../../../core/utils/service_locator.dart';

class EmployeeManagementPage extends StatelessWidget {
  const EmployeeManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<StoreRepository>();
    final employees = repository.employees;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Personnel', style: AppTypography.headlineMedium(context)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: employees.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final emp = employees[index];
          final bool isOn = emp['status'] == 'ON-SHIFT';
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(emp['name']![0], style: const TextStyle(color: AppColors.primary)),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(emp['name']!, style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)),
                      Text(emp['role']!, style: AppTypography.bodySmall(context)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: (isOn ? AppColors.success : AppColors.outline).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    emp['status']!,
                    style: AppTypography.labelSmall(context).copyWith(
                      color: isOn ? AppColors.success : AppColors.outline,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
