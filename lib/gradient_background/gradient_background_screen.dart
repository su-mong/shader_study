import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shader_study/gradient_background/playlist/playlist_page.dart';

import 'mixin/player_event_mixin.dart';
import 'mixin/player_state_mixin.dart';
import 'music_player/music_player_page.dart';
import 'widget/gradient_background_widget.dart';
import 'widget/playlist_app_bar.dart';

class GradientBackgroundScreen extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const GradientBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF121717),
      body: Stack(
        children: [
          /// gradient background
          const GradientBackgroundWidget(),

          /// main body
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                PlaylistAppBar(
                  isLogoWhite: isLogoWhite(ref),
                ),

                /// contents
                Expanded(
                  child: isSelected(ref)
                      ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        MusicPlayerPage(),
                        PlaylistPage(),
                      ],
                    ),
                  )
                      : PlaylistPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}