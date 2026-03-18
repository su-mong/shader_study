import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class GlitchShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final ui.Image cardImage;

  GlitchShaderPainter({
    required this.shader,
    required this.time,
    required this.cardImage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);
    shader.setImageSampler(0, cardImage);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant GlitchShaderPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.cardImage != cardImage;
  }
}
