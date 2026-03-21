import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/background_state_provider.dart';
import '../provider/player_current_selected_item_provider.dart';
import '../provider/player_is_collapsed_provider.dart';
import '../provider/playlist_provider.dart';

mixin PlayerEventMixin {
  void changeIsCollapsed(WidgetRef ref, bool value) {
    ref.read(playerIsCollapsedProvider.notifier).setCollapsed(value);
  }

  void changeSelectedItem(WidgetRef ref, int index) {
    ref.read(playerCurrentSelectedItemProvider.notifier).selectItem(index);
    ref.read(backgroundStateProvider.notifier).setState(
      ref.read(playlistProvider)[index].colorInfo,
    );
  }

  void selectPrev(WidgetRef ref) {
    final currentIndex = ref.read(playerCurrentSelectedItemProvider);
    if(currentIndex == null || currentIndex == 0) return;

    changeSelectedItem(ref, currentIndex - 1);
  }

  void selectNext(WidgetRef ref) {
    final currentIndex = ref.read(playerCurrentSelectedItemProvider);
    if(currentIndex == null || currentIndex == 12) return;

    changeSelectedItem(ref, currentIndex + 1);
  }
}