import 'playlist_song_color_model.dart';

class PlaylistSongModel {
  final String id;
  final String artistImage;
  final String artistName;
  final String songImageUrl;
  final String title;
  final String albumName;
  final int totalSeconds;
  final PlaylistSongColorModel colorInfo;

  const PlaylistSongModel(
    this.id, {
    required this.artistImage,
    required this.artistName,
    required this.songImageUrl,
    required this.title,
    required this.albumName,
    required this.totalSeconds,
    required this.colorInfo,
  });
}