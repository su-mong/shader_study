import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mixin/player_event_mixin.dart';
import '../../mixin/player_state_mixin.dart';
import '../../provider/player_mode_provider.dart';

class MusicPlayerModeChangeWidget extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const MusicPlayerModeChangeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 128,
      height: 32,
      child: Stack(
        children: [
          Container(
            width: 128,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: playerMode(ref) == PlayerModeState.music ? 0 : 60,
            child: Container(
              width: 68,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0x99000000),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setMusicMode(ref),
              child: Container(
                width: 68,
                height: 32,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 21 / 14,
                    letterSpacing: 0,
                    color: playerMode(ref) == PlayerModeState.music
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF121717),
                  ),
                  child: Text('노래'),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setVideoMode(ref),
              child: Container(
                width: 68,
                height: 32,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 21 / 14,
                    letterSpacing: 0,
                    color: playerMode(ref) == PlayerModeState.video
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF121717),
                  ),
                  child: Text('동영상'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}