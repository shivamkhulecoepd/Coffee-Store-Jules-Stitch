import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class AppGlassContainer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double blur;
  final double opacity;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;
  final List<BoxShadow>? boxShadow;
  final bool hasInnerBorder;

  const AppGlassContainer({
    super.key,
    required this.child,
    this.borderRadius,
    this.blur = 32,
    this.opacity = 0.8,
    this.width,
    this.height,
    this.padding,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.hasInnerBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveRadius = borderRadius ?? 28.r;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(effectiveRadius),
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle ? BorderRadius.circular(1000) : BorderRadius.circular(effectiveRadius),
        child: Stack(
          fit: (width != null || height != null) ? StackFit.loose : StackFit.loose, // Default to loose to avoid forcing children to expand unless specified
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Container(
                  decoration: BoxDecoration(
                    shape: shape,
                    borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(effectiveRadius),
                    color: AppColors.surfaceLight.withValues(alpha: opacity),
                  ),
                ),
              ),
            ),
            if (hasInnerBorder)
              Positioned.fill(
                child: CustomPaint(
                  painter: _GlassBorderPainter(
                    borderRadius: effectiveRadius,
                    shape: shape,
                  ),
                ),
              ),
            Padding(
              padding: padding ?? EdgeInsets.all(20.w),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassBorderPainter extends CustomPainter {
  final double borderRadius;
  final BoxShape shape;

  _GlassBorderPainter({required this.borderRadius, required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;
    final rect = Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1);
    final paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: AppColors.glassGradient,
      ).createShader(rect);

    if (shape == BoxShape.circle) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2 - 0.5, paint);
    } else {
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
