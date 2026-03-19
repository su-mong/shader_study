import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mixin/player_event_mixin.dart';
import 'mixin/player_state_mixin.dart';
import 'widget/gradient_background_widget.dart';
import 'widget/playlist_app_bar.dart';
import 'widget/playlist_song_item_widget.dart';

class GradientBackgroundScreen extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const GradientBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF121717),
      body: Stack(
        children: [
          /// gradient background
          const GradientBackgroundWidget(),

          /// main body
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                /// appbar
                const PlaylistAppBar(),

                /// contents
                Expanded(
                  child: ListView.builder(
                    itemCount: playlist(ref).length,
                    itemBuilder: (context, index) {
                      final item = playlist(ref)[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 6,
                        ),
                        child: PlaylistSongItemWidget(
                          isSelected: isSelected(ref, item.id),
                          model: item,
                          onClick: () => changeSelectedItem(ref, item),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}