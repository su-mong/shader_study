import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/playlist_song_color_model.dart';
import '../util/color_util.dart';

part 'background_state_provider.g.dart';

@riverpod
class BackgroundState extends _$BackgroundState {
  @override
  PlaylistSongColorModel? build() {
    return null;
  }

  void setState(PlaylistSongColorModel model) async {
    if(state == model) return;

    final colorStepsList = ColorUtil.generateColorSteps(
      state ?? _initialBackgroundColor,
      model,
    );

    for(var colorStep in colorStepsList) {
      state = colorStep;
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  static const PlaylistSongColorModel _initialBackgroundColor = PlaylistSongColorModel(
    primary: Color(0xFF121717),
    secondary: Color(0xFF121717),
    accent1: Color(0xFF121717),
    accent2: Color(0xFF121717),
    text: Color(0xFFFFFFFF),
    isLogoWhite: true,
  );
}