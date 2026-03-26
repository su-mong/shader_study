
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_mode_provider.g.dart';

@riverpod
class PlayerMode extends _$PlayerMode {
  @override
  PlayerModeState build() {
    return PlayerModeState.music;
  }

  void setMusicMode() {
    state = PlayerModeState.music;
  }

  void setVideoMode() {
    state = PlayerModeState.video;
  }
}

enum PlayerModeState {
  music, video;
}