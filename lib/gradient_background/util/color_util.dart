import 'dart:ui';

import '../model/playlist_song_color_model.dart';

abstract class ColorUtil {
  static List<PlaylistSongColorModel> generateColorSteps(
    PlaylistSongColorModel start,
    PlaylistSongColorModel end, {
    int steps = 20,
  }) {
    final List<PlaylistSongColorModel> colors = [];

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      colors.add(
        PlaylistSongColorModel(
          primary: Color.lerp(start.primary, end.primary, t)!,
          secondary: Color.lerp(start.secondary, end.secondary, t)!,
          accent1: Color.lerp(start.accent1, end.accent1, t)!,
          accent2: Color.lerp(start.accent2, end.accent2, t)!,
          text: Color.lerp(start.text, end.text, t)!,
          isLogoWhite: end.isLogoWhite,
        ),
      );
    }

    return colors;
  }
}