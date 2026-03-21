import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/playlist_song_color_model.dart';
import '../model/playlist_song_model.dart';
import '../provider/background_state_provider.dart';
import '../provider/player_current_selected_item_provider.dart';
import '../provider/player_is_collapsed_provider.dart';
import '../provider/playlist_provider.dart';

mixin PlayerStateMixin {
  bool isSelected(WidgetRef ref) => ref.watch(playerCurrentSelectedItemProvider.select((value) => value != null));
  bool isCollapsed(WidgetRef ref) => ref.watch(playerIsCollapsedProvider);
  List<PlaylistSongModel> playlist(WidgetRef ref) => ref.watch(playlistProvider);
  bool isItemSelected(WidgetRef ref, int index) => ref.watch(playerCurrentSelectedItemProvider.select((value) => value == index));
  int? selectedIndex(WidgetRef ref) => ref.watch(playerCurrentSelectedItemProvider);

  bool isBackgroundExist(WidgetRef ref) => ref.watch(backgroundStateProvider.select((value) => value != null));
  PlaylistSongColorModel? background(WidgetRef ref) => ref.watch(backgroundStateProvider);
  Color textColor(WidgetRef ref) => ref.watch(backgroundStateProvider.select((value) => value?.text ?? const Color(0xFFFFFFFF)));
  bool isLogoWhite(WidgetRef ref) => ref.watch(backgroundStateProvider.select((value) => value?.isLogoWhite ?? true));
}