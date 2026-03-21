import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../mixin/player_event_mixin.dart';
import '../mixin/player_state_mixin.dart';
import 'widget/playlist_song_item_widget.dart';

class PlaylistPage extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: isSelected(ref) ? true : false,
      physics: isSelected(ref) ? const NeverScrollableScrollPhysics() : null,
      itemCount: playlist(ref).length,
      itemBuilder: (context, index) {
        final item = playlist(ref)[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 6,
          ),
          child: PlaylistSongItemWidget(
            isSelected: isItemSelected(ref, index),
            model: item,
            onClick: () => changeSelectedItem(ref, index),
            textColor: textColor(ref),
          ),
        );
      },
    );
  }
}