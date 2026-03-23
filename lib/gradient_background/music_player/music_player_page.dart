import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../utils/context_extension.dart';
import '../mixin/player_event_mixin.dart';
import '../mixin/player_state_mixin.dart';
import '../widget/playlist_app_bar.dart';
import 'widget/music_player_control_widget.dart';
import 'widget/music_player_info_widget.dart';
import 'widget/music_player_mode_change_widget.dart';
import 'widget/music_player_show_playlist_widget.dart';
import 'widget/music_player_slider_widget.dart';

class MusicPlayerPage extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(selectedIndex(ref) == null) {
      return const SizedBox.shrink();
    }

    final item = playlist(ref)[selectedIndex(ref)!];

    return SizedBox(
      height: context.safeAreaHeight - PlaylistAppBar.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const MusicPlayerModeChangeWidget(),
          const Spacer(flex: 48), //const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            height: 240,
            child: Stack(
              children: [
                SizedBox(
                  width: 0,
                  child: YoutubePlayer(
                    controller: context.ytController,
                    enableFullScreenOnVerticalDrag: false,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${item.songImageUrl}',
                      width: 240,
                      height: 240,
                    ),
                  ),
                ),
              ],
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: MusicPlayerSliderWidget(),
          ),
          const Spacer(flex: 36), // const SizedBox(height: 36),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: MusicPlayerControlWidget(),
          ),
          const Spacer(flex: 116), // const Spacer(),
          MusicPlayerShowPlaylistWidget(
            isWhite: item.colorInfo.isLogoWhite,
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}