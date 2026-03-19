import 'playlist_song_color_model.dart';

class PlaylistSongModel {
  final String id;
  final String artistName;
  final String songImageUrl;
  final String title;
  final String albumName;
  final PlaylistSongColorModel colorInfo;

  const PlaylistSongModel(
    this.id, {
    required this.artistName,
    required this.songImageUrl,
    required this.title,
    required this.albumName,
    required this.colorInfo,
  });
}