import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_container.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Updates', style: AppTypography.headlineMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(24.w),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return AppGlassContainer(
            padding: EdgeInsets.all(20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(
                    index == 0 ? Icons.local_fire_department : Icons.notifications_outlined,
                    color: AppColors.primary,
                    size: 20.sp
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0 ? 'Sequence starting now!' : 'System synchronization complete.',
                        style: AppTypography.labelMedium(context).copyWith(fontWeight: FontWeight.w700)
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        index == 0
                          ? 'Your Signature Vanilla Latte is entering the extraction phase.'
                          : 'Your latest order session has been successfully transmitted to the station.',
                        style: AppTypography.bodySmall(context)
                      ),
                      SizedBox(height: 8.h),
                      Text('${index * 2 + 1} hours ago', style: AppTypography.dataMono(context).copyWith(fontSize: 10.sp, color: AppColors.outline)),
                    ],
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
