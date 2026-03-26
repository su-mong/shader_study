import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../mixin/player_event_mixin.dart';
import '../mixin/player_state_mixin.dart';
import '../provider/player_mode_provider.dart';
import '../util/color_util.dart';
import 'widget/music_player_control_widget.dart';
import 'widget/music_player_info_widget.dart';
import 'widget/music_player_mode_change_widget.dart';
import 'widget/music_player_show_playlist_widget.dart';
import 'widget/music_player_slider_widget.dart';

class ExpandingPlayerHeaderDelegate extends SliverPersistentHeaderDelegate with PlayerStateMixin {
  /// 상수값 모음
  static const double _minHeight = 72;
  static const double minImageSize = 52;
  static const double maxImageSize = 240;
  static const double miniPlayerTopPadding = 12;
  static const double miniPlayerHorizontalPadding = 16;

  final double maxHeight;
  final void Function(int index) onTap;

  const ExpandingPlayerHeaderDelegate({
    required this.maxHeight,
    required this.onTap,
  });

  @override
  double get minExtent => _minHeight;

  @override
  double get maxExtent => math.max(maxHeight, _minHeight);

  /// [_MusicPlayerWidget]의 메인 이미지의 y좌표.
  /// [_MusicPlayerWidget] 내부 배치를 바탕으로 계산한 값이다.
  double get _fullPlayerImageTopPosition => math.max(52 + ((maxHeight - 499) / 296 * 48), 0);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    final double currentHeight = (maxExtent - shrinkOffset).clamp(minExtent, maxExtent);

    // 이미지 & 비디오 크기 계산
    final double imageSize = _lerpDouble(minImageSize, maxImageSize, 1 - progress)!;
    final double videoWidth = _lerpDouble(minImageSize, MediaQuery.sizeOf(context).width, 1 - progress)!;

    // 이미지 & 비디오 위치: 최소일 때 왼쪽, 최대일 때 중앙
    final double topPadding = _lerpDouble(miniPlayerTopPadding, _fullPlayerImageTopPosition, 1 - progress)!;
    final double horizontalPadding = _lerpDouble(miniPlayerHorizontalPadding, (MediaQuery.sizeOf(context).width - imageSize) / 2, 1 - progress)!;
    final double videoLeftPadding = _lerpDouble(miniPlayerHorizontalPadding, 0, 1 - progress)!;

    return Consumer(
      builder: (context, ref, child) {
        final currentSong = playlist(ref)[selectedIndex(ref)!];
        final imageUrl = currentSong.songImageUrl;

        return SizedBox(
          height: currentHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // video
              Positioned(
                top: topPadding,
                left: videoLeftPadding,
                child: SizedBox(
                  width: playerMode(ref) == PlayerModeState.music ? 0 : videoWidth,
                  height: playerMode(ref) == PlayerModeState.music ? null : imageSize,
                  child: YoutubePlayer(
                    controller: context.ytController,
                    enableFullScreenOnVerticalDrag: false,
                  ),
                ),
              ),

              // image
              if(playerMode(ref) == PlayerModeState.music)
                Positioned(
                  top: topPadding,
                  left: horizontalPadding,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(_lerpDouble(4, 8, 1 - progress)!),
                    child: Image.asset(
                      'assets/images/$imageUrl',
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              // 미니사이즈 Music Player
              if(progress >= 0.8)
                Opacity(
                  opacity: (progress - 0.8) * 5,
                  child: const _MiniPlayerWidget(),
                ),

              /// 풀사이즈 Music Player
              if(progress <= 0.3)
                Opacity(
                  opacity: 1 - (progress * 3),
                  child: _MusicPlayerWidget(onTap: onTap),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool shouldRebuild(covariant ExpandingPlayerHeaderDelegate oldDelegate) => true;

  // lerpDouble 도우미 (null 안전하게)
  double? _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}

class _MusicPlayerWidget extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  final void Function(int index) onTap;

  const _MusicPlayerWidget({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(selectedIndex(ref) == null) {
      return const SizedBox.shrink();
    }

    final item = playlist(ref)[selectedIndex(ref)!];

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        const MusicPlayerModeChangeWidget(),
        const Spacer(flex: 48),

        /// image area
        SizedBox(
          width: ExpandingPlayerHeaderDelegate.maxImageSize,
          height: ExpandingPlayerHeaderDelegate.maxImageSize,
        ),

        const Spacer(flex: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: MusicPlayerInfoWidget(
            artistImage: item.artistImage,
            artistName: item.artistName,
            title: item.title,
            albumName: item.albumName,
            textColor: item.colorInfo.text,
            isFavorite: false,
          ),
        ),
        const Spacer(flex: 48),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: MusicPlayerSliderWidget(isMiniPlayer: false),
        ),
        const Spacer(flex: 36),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: MusicPlayerControlWidget(isMiniPlayer: false),
        ),
        const Spacer(flex: 116),
        MusicPlayerShowPlaylistWidget(
          onTap: () => onTap(selectedIndex(ref)!),
          isWhite: item.colorInfo.isLogoWhite,
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _MiniPlayerWidget extends ConsumerWidget with PlayerStateMixin, PlayerEventMixin {
  const _MiniPlayerWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(selectedIndex(ref) == null) {
      return const SizedBox.shrink();
    }

    final item = playlist(ref)[selectedIndex(ref)!];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MusicPlayerSliderWidget(isMiniPlayer: true),
        Container(
          padding: const EdgeInsets.fromLTRB(
            ExpandingPlayerHeaderDelegate.miniPlayerHorizontalPadding,
            ExpandingPlayerHeaderDelegate.miniPlayerTopPadding - 4,
            ExpandingPlayerHeaderDelegate.miniPlayerHorizontalPadding,
            ExpandingPlayerHeaderDelegate.miniPlayerTopPadding - 5,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: item.colorInfo.isLogoWhite
                    ? item.colorInfo.primary.brighten(0.2)
                    : item.colorInfo.primary.darken(0.2),
              ),
            ),
          ),
          child: Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// image area
              SizedBox(
                width: ExpandingPlayerHeaderDelegate.minImageSize,
                height: ExpandingPlayerHeaderDelegate.minImageSize,
              ),

              Expanded(
                child: MiniMusicPlayerInfoWidget(
                  artistName: item.artistName,
                  title: item.title,
                  artistColor: item.colorInfo.text, // const Color(0xFF9EB5B8)
                  titleColor: item.colorInfo.text,
                ),
              ),
              const MusicPlayerControlWidget(isMiniPlayer: true),
            ],
          ),
        ),
      ],
    );
  }
}