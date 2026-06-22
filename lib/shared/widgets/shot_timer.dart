import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class ShotTimer extends StatelessWidget {
  final double progress;
  final String time;

  const ShotTimer({
    super.key,
    required this.progress,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(120.w, 120.w),
            painter: _ShotTimerPainter(
              progress: progress,
              backgroundColor: AppColors.espressoBold,
              gradientColors: [AppColors.espressoBold, AppColors.crema],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: AppTypography.headlineLarge(context).copyWith(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'SEC',
                style: AppTypography.labelSmall(context).copyWith(
                  fontSize: 10.sp,
                  letterSpacing: 2,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShotTimerPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final List<Color> gradientColors;

  _ShotTimerPainter({
    required this.progress,
    required this.backgroundColor,
    required this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4.w;
    final strokeWidth = 8.w;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, bgPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final fgPaint = Paint()
      ..shader = SweepGradient(
        colors: gradientColors,
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
