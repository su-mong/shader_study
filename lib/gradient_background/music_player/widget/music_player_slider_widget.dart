import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../mixin/player_state_mixin.dart';

class MusicPlayerSliderWidget extends ConsumerWidget with PlayerStateMixin {
  const MusicPlayerSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<YoutubeVideoState>(
      stream: context.ytController.videoStateStream,
      builder: (context, snapshot) {
        final position = snapshot.data?.position.inSeconds ?? 0;
        final duration = context.ytController.metadata.duration.inSeconds;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 8,
                activeTrackColor: isLogoWhite(ref) ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
                inactiveTrackColor: isLogoWhite(ref) ? const Color(0x79000000) : const Color(0x79FFFFFF),
                trackShape: const RectangularSliderTrackShape(),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
              ),
              child: Slider(
                min: 0,
                max: 1,
                value: duration == 0 ? 0 : position / duration,
                onChanged: (value) {
                  // int startDuration = 0;
                  // final currentSelectedItem = ref.read(playerCurrentSelectedItemProvider);
                  //
                  // if (currentSelectedItem.mainIndex != null) {
                  //   final item = ref.read(playerPlaylistProvider)[currentSelectedItem.mainIndex!];
                  //   switch (item) {
                  //     case PlaylistLiveModel _:
                  //       if (currentSelectedItem.subIndex != null) {
                  //         startDuration = item.songList[currentSelectedItem.subIndex!].startDuration.inSeconds;
                  //       }
                  //     case PlaylistSongModel _:
                  //       startDuration = 0;
                  //   }
                  // }
                  //
                  // _seekTo(startDuration + value);
                },
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _secondsToMSs(position),
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 21 / 12,
                    letterSpacing: 0,
                    color: textColor(ref),
                  ),
                ),
                Text(
                  duration == 0 ? '-' : _secondsToMSs(duration),
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    height: 21 / 12,
                    letterSpacing: 0,
                    color: textColor(ref),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String _secondsToMSs(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
}