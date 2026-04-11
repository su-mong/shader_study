import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist_song_color_model.freezed.dart';

@freezed
abstract class PlaylistSongColorModel with _$PlaylistSongColorModel {
  const factory PlaylistSongColorModel({
    required Color primary,
    required Color secondary,
    required Color accent1,
    required Color accent2,
    required Color text,
    required bool isLogoWhite,
  }) = _PlaylistSongColorModel;
}