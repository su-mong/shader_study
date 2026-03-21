import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../mixin/player_event_mixin.dart';

class MusicPlayerControlWidget extends ConsumerWidget with PlayerEventMixin {
  const MusicPlayerControlWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _smallButton(icon: 'icon_shuffle', onTap: null),
        const Spacer(flex: 5),
        _bigButton(icon: 'icon_skip_previous_filled', onTap: () => selectPrev(ref)),
        const Spacer(flex: 6),
        _bigButton(icon: 'icon_play_arrow_filled', onTap: null),
        const Spacer(flex: 6),
        _bigButton(icon: 'icon_skip_next_filled', onTap: () => selectNext(ref)),
        const Spacer(flex: 5),
        _smallButton(icon: 'icon_repeat', onTap: null),
      ],
    );
  }

  Widget _smallButton({
    required String icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SvgPicture.asset(
          'assets/images/$icon.svg',
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Widget _bigButton({
    required String icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/images/$icon.svg',
        width: 40,
        height: 40,
      ),
    );
  }
}