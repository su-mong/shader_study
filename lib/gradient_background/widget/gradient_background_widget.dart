import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mixin/player_state_mixin.dart';
import 'gradient_background_painter.dart';

/// If background is not selected, [GradientBackgroundWidget] remains empty([SizedBox.shrink()]).
/// After user selected item, [GradientBackgroundWidget] calls [_GradientBackgroundAnimationWidget], and start timer to animate gradient background.
///
/// If the two widgets are combined into one, even if the background is not selected, the Timer keeps running and the [setState] continues to be called,
///   which causes the [build] method to continue to be called.
/// This creates a waste of resources because the rebuild continues to occur even if the gradient animation does not work.
class GradientBackgroundWidget extends ConsumerStatefulWidget {
  const GradientBackgroundWidget({super.key});

  @override
  ConsumerState<GradientBackgroundWidget> createState() => _GradientBackgroundWidgetState();
}

class _GradientBackgroundWidgetState extends ConsumerState<GradientBackgroundWidget> with PlayerStateMixin {
  FragmentShader? _shader;

  void _loadShader() async {
    final program = await FragmentProgram.fromAsset('shaders/gradient_flow.frag');
    _shader = program.fragmentShader();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _loadShader(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(_shader == null || isBackgroundExist(ref) == false) {
      return const SizedBox.shrink();
    }

    return _GradientBackgroundAnimationWidget(
      shader: _shader!,
      primary: background(ref)!.primary,
      secondary: background(ref)!.secondary,
      accent1: background(ref)!.accent1,
      accent2: background(ref)!.accent2,
    );
  }
}

class _GradientBackgroundAnimationWidget extends StatefulWidget {
  final FragmentShader shader;
  final Color primary;
  final Color secondary;
  final Color accent1;
  final Color accent2;

  const _GradientBackgroundAnimationWidget({
    required this.shader,
    required this.primary,
    required this.secondary,
    required this.accent1,
    required this.accent2,
  });

  @override
  State<_GradientBackgroundAnimationWidget> createState() => _GradientBackgroundAnimationWidgetState();
}

class _GradientBackgroundAnimationWidgetState extends State<_GradientBackgroundAnimationWidget> {
  late Timer _timer;
  double _delta = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        /// if duration is smaller, then the gradient animation is faster
        _timer = Timer.periodic(
          const Duration(milliseconds: 8),
          (_) {
            setState(() {
              _delta += 1 / 60;
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, double.infinity),
      painter: GradientBackgroundPainter(
        widget.shader,
        _delta,
        primary: widget.primary,
        secondary: widget.secondary,
        accent1: widget.accent1,
        accent2: widget.accent2,
      ),
    );
  }
}