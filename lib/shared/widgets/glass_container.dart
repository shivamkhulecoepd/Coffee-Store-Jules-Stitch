import 'dart:ui';
import 'package:flutter/material.dart';

class AppGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;
  final Color? color;
  final BoxBorder? border;

  const AppGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.blur = 24,
    this.opacity = 0.1,
    this.width,
    this.height,
    this.padding,
    this.shape = BoxShape.rectangle,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle ? BorderRadius.circular(1000) : BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            // BackdropFilter applies blur to whatever is behind this widget
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Container(
                  decoration: BoxDecoration(
                    shape: shape,
                    borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
                    color: (color ?? Colors.white).withOpacity(opacity),
                    border: border ?? Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            // Content layer
            Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
