import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shader_study/gradient_background/playlist/playlist_page.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'mixin/player_event_mixin.dart';
import 'mixin/player_state_mixin.dart';
import 'music_player/music_player_page.dart';
import 'widget/gradient_background_widget.dart';
import 'widget/playlist_app_bar.dart';

class GradientBackgroundScreen extends ConsumerStatefulWidget {
  const GradientBackgroundScreen({super.key});

  @override
  ConsumerState<GradientBackgroundScreen> createState() => _GradientBackgroundScreenState();
}

class _GradientBackgroundScreenState extends ConsumerState<GradientBackgroundScreen> with PlayerStateMixin, PlayerEventMixin {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        enableCaption: false,
        showControls: false,
        showFullscreenButton: false,
        showVideoAnnotations: false,
        loop: false,
        origin: 'https://www.youtube-nocookie.com',
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
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
                        : const PlaylistPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}