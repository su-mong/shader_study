import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shader_study/gradient_background/provider/background_state_provider.dart';

import '../model/playlist_song_model.dart';
import '../provider/player_current_selected_item_provider.dart';
import '../provider/player_is_collapsed_provider.dart';

mixin PlayerEventMixin {
  void changeIsCollapsed(WidgetRef ref, bool value) {
    ref.read(playerIsCollapsedProvider.notifier).setCollapsed(value);
  }

  void changeSelectedItem(WidgetRef ref, PlaylistSongModel model) {
    ref.read(playerCurrentSelectedItemProvider.notifier).selectItem(model.id);
    ref.read(backgroundStateProvider.notifier).setState(model.colorInfo);
  }
}