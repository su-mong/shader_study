import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/context_extension.dart';
import '../mixin/player_event_mixin.dart';
import '../mixin/player_state_mixin.dart';
import '../widget/playlist_app_bar.dart';
import 'widget/music_player_control_widget.dart';
import 'widget/music_player_info_widget.dart';
import 'widget/music_player_mode_change_widget.dart';
import 'widget/music_player_show_playlist_widget.dart';
import 'widget/music_player_slider_widget.dart';

class MusicPlayerPage extends ConsumerStatefulWidget {
  const MusicPlayerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends ConsumerState<MusicPlayerPage> with PlayerStateMixin, PlayerEventMixin {
  @override
  Widget build(BuildContext context) {
    final item = playlist(ref)[selectedIndex(ref)!];

    return SizedBox(
      height: context.safeAreaHeight - PlaylistAppBar.height - 56 - 28,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const MusicPlayerModeChangeWidget(),
          const Spacer(flex: 48), //const SizedBox(height: 48),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/${item.songImageUrl}',
              width: 240,
              height: 240,
            ),
          ),
          const Spacer(flex: 48), // const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MusicPlayerInfoWidget(
              artistImage: item.artistImage,
              artistName: item.artistName,
              title: item.title,
              albumName: item.albumName,
              textColor: item.colorInfo.text,
              isFavorite: false,
            ),
          ),
          const Spacer(flex: 48), // const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MusicPlayerSliderWidget(
              currentTimeSeconds: 76,
              totalTimeSeconds: item.totalSeconds,
              activeColor: item.colorInfo.isLogoWhite ? const Color(0xFF121717) : const Color(0xFFFFFFFF),
              inactiveColor: item.colorInfo.isLogoWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
            ),
          ),
          const Spacer(flex: 36), // const SizedBox(height: 36),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: MusicPlayerControlWidget(),
          ),
          const Spacer(flex: 116), // const Spacer(),
          const MusicPlayerShowPlaylistWidget(),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}