import 'dart:ui';

import 'package:flutter/rendering.dart';

class GradientBackgroundPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  final Color primary;
  final Color secondary;
  final Color accent1;
  final Color accent2;

  const GradientBackgroundPainter(
    FragmentShader fragmentShader,
    this.time, {
    required this.primary,
    required this.secondary,
    required this.accent1,
    required this.accent2,
  }) : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    shader.setFloat(3, primary.r);
    shader.setFloat(4, primary.g);
    shader.setFloat(5, primary.b);
    shader.setFloat(6, secondary.r);
    shader.setFloat(7, secondary.g);
    shader.setFloat(8, secondary.b);
    shader.setFloat(9, accent1.r);
    shader.setFloat(10, accent1.g);
    shader.setFloat(11, accent1.b);
    shader.setFloat(12, accent2.r);
    shader.setFloat(13, accent2.g);
    shader.setFloat(14, accent2.b);

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}