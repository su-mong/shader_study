import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/background_state_provider.dart';
import '../provider/player_current_selected_item_provider.dart';
import '../provider/player_mode_provider.dart';
import '../provider/playlist_provider.dart';

mixin PlayerEventMixin {
  void changeSelectedItem(WidgetRef ref, int index) {
    final currentSong = ref.read(playlistProvider).list[index];

    ref.read(playerCurrentSelectedItemProvider.notifier).selectItem(index);
    ref.read(backgroundStateProvider.notifier).setState(currentSong.colorInfo);
  }

  void changeSelectedItemById(WidgetRef ref, String id) {
    final index = ref.read(playlistProvider).list.indexWhere((song) => song.id == id);
    changeSelectedItem(ref, index);
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

  void setMusicMode(WidgetRef ref) {
    ref.read(playerModeProvider.notifier).setMusicMode();
  }

  void setVideoMode(WidgetRef ref) {
    ref.read(playerModeProvider.notifier).setVideoMode();
  }

  bool toggleList(WidgetRef ref) {
    ref.read(playlistProvider.notifier).toggle();

    final isSelected = ref.read(playerCurrentSelectedItemProvider.select((value) => value != null));
    if(isSelected) {
      changeSelectedItem(ref, 0);
    }

    return isSelected;
  }
}