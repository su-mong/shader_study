import 'package:flutter/material.dart';

class MusicPlayerSliderWidget extends StatelessWidget {
  final int currentTimeSeconds;
  final int totalTimeSeconds;
  final Color activeColor;
  final Color inactiveColor;

  const MusicPlayerSliderWidget({
    super.key,
    required this.currentTimeSeconds,
    required this.totalTimeSeconds,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
            activeTrackColor: activeColor,
            inactiveTrackColor: inactiveColor,
            trackShape: const RectangularSliderTrackShape(),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
          ),
          child: Slider(
            min: 0,
            max: 1,
            value: currentTimeSeconds / totalTimeSeconds,
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
              _secondsToMSs(currentTimeSeconds),
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 21 / 12,
                letterSpacing: 0,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              _secondsToMSs(totalTimeSeconds),
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 21 / 12,
                letterSpacing: 0,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _secondsToMSs(int seconds) {
    final int minutes = seconds ~/ 60;
    final int secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
}