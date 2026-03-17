import 'dart:ui';

import 'package:flutter/rendering.dart';

class GradientBackgroundPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  final Color primaryColor;
  final Color secondaryColor;
  final Color accent1Color;
  final Color accent2Color;

  const GradientBackgroundPainter(
    FragmentShader fragmentShader,
    this.time, {
    required this.primaryColor,
    required this.secondaryColor,
    required this.accent1Color,
    required this.accent2Color,
  }) : shader = fragmentShader;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    shader.setFloat(3, primaryColor.r);
    shader.setFloat(4, primaryColor.g);
    shader.setFloat(5, primaryColor.b);
    shader.setFloat(6, secondaryColor.r);
    shader.setFloat(7, secondaryColor.g);
    shader.setFloat(8, secondaryColor.b);
    shader.setFloat(9, accent1Color.r);
    shader.setFloat(10, accent1Color.g);
    shader.setFloat(11, accent1Color.b);
    shader.setFloat(12, accent2Color.r);
    shader.setFloat(13, accent2Color.g);
    shader.setFloat(14, accent2Color.b);

    paint.shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}