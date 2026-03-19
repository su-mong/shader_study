import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../mixin/player_state_mixin.dart';

class PlaylistAppBar extends StatelessWidget with PlayerStateMixin {
  const PlaylistAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BackButton(
                  color: const Color(0xFFFFFFFF),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo_white.png',
              height: 24,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}