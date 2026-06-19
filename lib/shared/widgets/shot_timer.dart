import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ShotTimer extends StatelessWidget {
  final double progress;
  final String time;

  const ShotTimer({super.key, required this.progress, required this.time});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140.w,
          height: 140.w,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 10.w,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(time, style: AppTypography.displayLarge.copyWith(fontSize: 36.sp)),
            Text('SECONDS', style: AppTypography.labelSmall.copyWith(color: AppColors.outline, fontSize: 10.sp)),
          ],
        ),
      ],
    );
  }
}
