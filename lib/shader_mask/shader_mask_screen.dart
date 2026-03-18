import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shader_study/common/common_app_bar.dart';
import 'package:shader_study/shader_mask/glitch_shader_painter.dart';
import 'package:shader_study/shader_mask/testimonial_card.dart';

class ShaderMaskScreen extends StatefulWidget {
  const ShaderMaskScreen({super.key});

  @override
  State<ShaderMaskScreen> createState() => _ShaderMaskScreenState();
}

class _ShaderMaskScreenState extends State<ShaderMaskScreen>
    with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  Ticker? _ticker;
  double _time = 0;
  ui.Image? _cardImage;
  final _boundaryKey = GlobalKey();
  bool _glitching = false;

  @override
  void initState() {
    super.initState();
    _loadShader();
  }

  Future<void> _loadShader() async {
    final program =
        await ui.FragmentProgram.fromAsset('shaders/glitch_transition.frag');
    _shader = program.fragmentShader();
    setState(() {});

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _captureCard();
    });
  }

  Future<void> _captureCard() async {
    final boundary = _boundaryKey.currentContext?.findRenderObject()
        as RenderRepaintBoundary?;
    if (boundary == null) return;

    final image = await boundary.toImage(pixelRatio: 2.0);
    setState(() {
      _cardImage = image;
    });
  }

  void _startGlitch() {
    if (_glitching) return;
    _glitching = true;
    _time = 0;

    _ticker?.dispose();
    _ticker = createTicker((elapsed) {
      final t = elapsed.inMilliseconds / 1000.0;
      setState(() {
        _time = t;
      });

      // Reset after 1.5 seconds
      if (t > 1.5) {
        _ticker?.stop();
        setState(() {
          _time = 0;
          _glitching = false;
        });
      }
    })..start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _cardImage?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Shader Mask Example'),
      body: SafeArea(
        child: GestureDetector(
          onTap: (_shader != null && _cardImage != null) ? _startGlitch : null,
          child: Center(
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Before shader is loaded or card is captured, show the raw card
    if (_shader == null || _cardImage == null) {
      return RepaintBoundary(
        key: _boundaryKey,
        child: const TestimonialCard(),
      );
    }

    // Once captured, render through the shader
    return AspectRatio(
      aspectRatio: 626 / 1200,
      child: CustomPaint(
        painter: GlitchShaderPainter(
          shader: _shader!,
          time: _time,
          cardImage: _cardImage!,
        ),
      ),
    );
  }
}
