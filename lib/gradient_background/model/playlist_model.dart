import 'package:freezed_annotation/freezed_annotation.dart';

import 'playlist_song_model.dart';

part 'playlist_model.freezed.dart';

enum PlaylistType {
  stellive,
  hololive;
}

@freezed
abstract class PlaylistModel with _$PlaylistModel {
  const factory PlaylistModel({
    required PlaylistType type,
    required List<PlaylistSongModel> list,
  }) = _PlaylistModel;
}