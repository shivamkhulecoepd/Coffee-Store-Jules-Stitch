import 'package:flutter/material.dart';

class SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  SparklinePainter({required this.data, required this.color});

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
