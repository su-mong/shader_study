import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../mixin/player_state_mixin.dart';

class PlaylistAppBar extends AppBar with PlayerStateMixin {
  PlaylistAppBar({super.key}) : super(
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 56,
    leading: Builder(
      builder: (context) => BackButton(
        color: const Color(0xFFFFFFFF),
        onPressed: () => context.pop(),
      ),
    ),
    title: Image.asset(
      'assets/images/logo_white.png',
      height: 24,
      fit: BoxFit.fitHeight,
    ),
    flexibleSpace: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/banner_miko.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.5),
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ],
    ),
  );
}