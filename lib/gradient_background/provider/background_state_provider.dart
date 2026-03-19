import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/playlist_song_color_model.dart';

part 'background_state_provider.g.dart';

@riverpod
class BackgroundState extends _$BackgroundState {
  @override
  PlaylistSongColorModel? build() {
    return null;
  }

  void setState(PlaylistSongColorModel model) {
    state = model;
  }
}