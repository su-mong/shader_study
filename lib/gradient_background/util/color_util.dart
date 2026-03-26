import 'dart:ui';

import 'package:flutter/material.dart';

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

extension ColorExtension on Color {
  /// amount: 0.0 ~ 1.0 (기본 0.1 = 10% 어둡게)
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness(
      (hsl.lightness - amount).clamp(0.0, 1.0),
    );
    return hslDark.toColor();
  }

  // 참고: 밝게 하려면 brighten()도 만들 수 있습니다.
  Color brighten([double amount = 0.1]) {
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }
}