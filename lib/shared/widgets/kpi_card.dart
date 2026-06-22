import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'glass_container.dart';
import 'sparkline_painter.dart';

class KPICard extends StatelessWidget {
  final String label;
  final String value;
  final List<double> chartData;
  final Color chartColor;

  const KPICard({
    super.key,
    required this.label,
    required this.value,
    required this.chartData,
    this.chartColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AppGlassContainer(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSmall(context).copyWith(
              color: AppColors.outline,
              letterSpacing: 1.2,
              fontSize: 9.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTypography.headlineLarge(context).copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
            ),
            maxLines: 1,
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 32.h,
            width: double.infinity,
            child: CustomPaint(
              painter: SparklinePainter(
                data: chartData,
                color: chartColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
