import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
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
      padding: EdgeInsets.all(24.w),
      boxShadow: AppTheme.premiumShadow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: AppTypography.labelSmall.copyWith(color: AppColors.outline, letterSpacing: 1.5)),
          SizedBox(height: 8.h),
          Text(value, style: AppTypography.headlineLarge),
          const Spacer(),
          SizedBox(
            height: 30.h,
            width: double.infinity,
            child: CustomPaint(
              painter: SparklinePainter(data: chartData, color: chartColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
