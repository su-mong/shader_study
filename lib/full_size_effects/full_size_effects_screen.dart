import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';

import '../common/common_app_bar.dart';
import '../common/shader_painter.dart';

class FullSizeEffectsScreen extends StatefulWidget {
  const FullSizeEffectsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FullSizeEffectsScreenState();
}

class _FullSizeEffectsScreenState extends State<FullSizeEffectsScreen> {
  late Timer _timer;
  double _delta = 0;
  FragmentShader? _shader;

  final List<Color> hueColors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 255, 0, 255)
  ];

  double value = 0.0;
  void onChanged(double value) => this.value = value;

  void _loadShader() async {
    final program = await FragmentProgram.fromAsset('shaders/background_eye_of_old_magic_dragon.frag');
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
        title: 'Full Size Effects Example',
      ),
      body: (_shader == null)
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SliderPicker(
              min: 0.0,
              max: 1.0,
              value: value,
              onChanged: (value) => super.setState(
                () => onChanged(value),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: hueColors),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomPaint(
              size: Size(double.infinity, double.infinity),
              painter: ShaderPainter(_shader!, _delta),
            ),
          ),
        ],
      ),
    );
  }
}