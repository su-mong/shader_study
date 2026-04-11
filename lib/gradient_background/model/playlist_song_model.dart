import 'package:freezed_annotation/freezed_annotation.dart';

import 'playlist_song_color_model.dart';

part 'playlist_song_model.freezed.dart';

@freezed
abstract class PlaylistSongModel with _$PlaylistSongModel {
  const factory PlaylistSongModel(
    String id, {
    required String artistImage,
    required String artistName,
    required String songImageUrl,
    required String title,
    required String albumName,
    required PlaylistSongColorModel colorInfo,
  }) = _PlaylistSongModel;
}