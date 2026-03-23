import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../mixin/player_event_mixin.dart';
import '../../mixin/player_state_mixin.dart';

class MusicPlayerControlWidget extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const MusicPlayerControlWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogoWhite = playlist(ref)[selectedIndex(ref)!].colorInfo.isLogoWhite;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _smallButton(
          icon: 'icon_shuffle',
          isWhite: isLogoWhite,
          onTap: null,
        ),
        const Spacer(flex: 5),
        _bigButton(
          icon: 'icon_skip_previous_filled',
          isWhite: isLogoWhite,
          onTap: () {
            context.ytController.previousVideo();
            selectPrev(ref);
          },
        ),
        const Spacer(flex: 6),
        YoutubeValueBuilder(
          builder: (context, value) {
            return _bigButton(
              icon: value.playerState == PlayerState.playing
                  ? 'icon_pause_filled'
                  : 'icon_play_arrow_filled',
              isWhite: isLogoWhite,
              onTap: () => _toggle(
                context.ytController,
                isPlaying: value.playerState == PlayerState.playing,
              ),
            );
          },
        ),
        const Spacer(flex: 6),
        _bigButton(
          icon: 'icon_skip_next_filled',
          isWhite: isLogoWhite,
          onTap: () {
            context.ytController.nextVideo();
            selectNext(ref);
          },
        ),
        const Spacer(flex: 5),
        _smallButton(
          icon: 'icon_repeat',
          isWhite: isLogoWhite,
          onTap: null,
        ),
      ],
    );
  }

  Widget _smallButton({
    required String icon,
    required VoidCallback? onTap,
    required bool isWhite,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/images/$icon.svg',
          width: 24,
          height: 24,
          color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
        ),
      ),
    );
  }

  Widget _bigButton({
    required String icon,
    required VoidCallback? onTap,
    required bool isWhite,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/images/$icon.svg',
        width: 40,
        height: 40,
        color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
      ),
    );
  }

  void _toggle(
    YoutubePlayerController youtubeController, {
    required bool isPlaying,
  }) {
    if(isPlaying) {
      youtubeController.pauseVideo();
    } else {
      youtubeController.playVideo();
    }
  }
}