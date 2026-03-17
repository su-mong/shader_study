import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../common/common_app_bar.dart';
import 'gradient_background_painter.dart';

class GradientBackgroundScreen extends StatefulWidget {
  const GradientBackgroundScreen({super.key});

  @override
  State<GradientBackgroundScreen> createState() => _GradientBackgroundScreenState();
}

class _GradientBackgroundScreenState extends State<GradientBackgroundScreen> {
  late Timer _timer;
  double _delta = 0;
  FragmentShader? _shader;

  void _loadShader() async {
    final program = await FragmentProgram.fromAsset('shaders/gradient_flow.frag');
    _shader = program.fragmentShader();
    setState(() {});

    _timer = Timer.periodic(
      const Duration(milliseconds: 8),
          (_) {
        setState(() {
          _delta += 1 / 60;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadShader();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Gradient Background',
      ),
      body: (_shader == null)
          ? const Center(child: CircularProgressIndicator())
          : CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: GradientBackgroundPainter(
          _shader!,
          _delta,
          primaryColor: const Color(0xFFFF6B00),
          secondaryColor: const Color(0xFFFF4500),
          accent1Color: const Color(0xFFFFAA00),
          accent2Color: const Color(0xFFFF8A50),
        ),
      ),
    );
  }
}
