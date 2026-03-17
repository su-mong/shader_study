import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../common/common_app_bar.dart';
import '../common/shader_painter.dart';

class SeascapeScreen extends StatefulWidget {
  const SeascapeScreen({super.key});

  @override
  State<SeascapeScreen> createState() => _SeascapeScreenState();
}

class _SeascapeScreenState extends State<SeascapeScreen> {
  late Timer _timer;
  double _delta = 0;
  FragmentShader? _shader;

  void _loadShader() async {
    final program = await FragmentProgram.fromAsset('shaders/seascape.frag');
    _shader = program.fragmentShader();
    setState(() {});

    _timer = Timer.periodic(
      const Duration(milliseconds: 32),
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
        title: 'Seascape',
      ),
      body: (_shader == null)
          ? const Center(child: CircularProgressIndicator())
          : CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: ShaderPainter(_shader!, _delta),
      ),
    );
  }
}
