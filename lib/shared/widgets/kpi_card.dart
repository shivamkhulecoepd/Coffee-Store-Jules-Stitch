import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_theme.dart';
import 'glass_container.dart';

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.toUpperCase(), style: AppTypography.labelSmall(context).copyWith(color: AppColors.outline, letterSpacing: 1.5)),
          SizedBox(height: 8.h),
          Text(value, style: AppTypography.headlineLarge(context)),
          SizedBox(height: 24.h),
          SizedBox(
            height: 30.h,
            width: double.infinity,
            child: CustomPaint(
              painter: _SparklinePainter(data: chartData, color: chartColor.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.length < 2) return;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    final xStep = size.width / (data.length - 1);
    final max = data.reduce((a, b) => a > b ? a : b);
    final min = data.reduce((a, b) => a < b ? a : b);
    final range = max - min == 0 ? 1.0 : max - min;
    path.moveTo(0, size.height - ((data[0] - min) / range) * size.height);
    for (int i = 1; i < data.length; i++) {
      path.lineTo(i * xStep, size.height - ((data[i] - min) / range) * size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
