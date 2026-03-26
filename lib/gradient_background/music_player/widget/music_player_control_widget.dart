import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../mixin/player_event_mixin.dart';
import '../../mixin/player_state_mixin.dart';

class MusicPlayerControlWidget extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  final bool isMiniPlayer;

  const MusicPlayerControlWidget({
    super.key,
    required this.isMiniPlayer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLogoWhite = playlist(ref)[selectedIndex(ref)!].colorInfo.isLogoWhite;

    if(isMiniPlayer) {
      return Row(
        children: [
          _playPauseButton(ref),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.ytController.nextVideo();
              selectNext(ref);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
              child: SvgPicture.asset(
                'assets/images/icon_skip_next_filled.svg',
                width: 24,
                height: 24,
                color: isLogoWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
              ),
            ),
          ),
        ],
      );
    }

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
        _playPauseButton(ref),
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

  Widget _playPauseButton(WidgetRef ref) {
    if(isMiniPlayer) {
      if(isLogoWhite(ref)) {
        return YoutubeValueBuilder(
          builder: (context, value) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _toggle(
                context.ytController,
                isPlaying: value.playerState == PlayerState.playing,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
                child: SvgPicture.asset(
                  'assets/images/'
                      '${value.playerState == PlayerState.playing ? 'icon_pause_filled' : 'icon_play_arrow_filled'}.svg',
                  width: 24,
                  height: 24,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            );
          },
        );
      } else {
        return YoutubeValueBuilder(
          builder: (context, value) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _toggle(
                context.ytController,
                isPlaying: value.playerState == PlayerState.playing,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
                child: SvgPicture.asset(
                  'assets/images/'
                      '${value.playerState == PlayerState.playing ? 'icon_pause_filled' : 'icon_play_arrow_filled'}.svg',
                  width: 24,
                  height: 24,
                  color: const Color(0xFF121717),
                ),
              ),
            );
          },
        );
      }
    }

    if(isLogoWhite(ref)) {
      return YoutubeValueBuilder(
        builder: (context, value) {
          return _bigButton(
            icon: value.playerState == PlayerState.playing
                ? 'icon_pause_filled'
                : 'icon_play_arrow_filled',
            isWhite: true,
            onTap: () => _toggle(
              context.ytController,
              isPlaying: value.playerState == PlayerState.playing,
            ),
          );
        },
      );
    }

    return YoutubeValueBuilder(
      builder: (context, value) {
        return _bigButton(
          icon: value.playerState == PlayerState.playing
              ? 'icon_pause_filled'
              : 'icon_play_arrow_filled',
          isWhite: false,
          onTap: () => _toggle(
            context.ytController,
            isPlaying: value.playerState == PlayerState.playing,
          ),
        );
      },
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