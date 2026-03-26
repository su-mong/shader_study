import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../utils/context_extension.dart';
import 'mixin/player_event_mixin.dart';
import 'mixin/player_state_mixin.dart';
import 'music_player/music_player_page.dart';
import 'playlist/playlist_page.dart';
import 'provider/player_current_seconds_provider.dart';
import 'provider/player_mode_provider.dart';
import 'widget/gradient_background_widget.dart';
import 'widget/playlist_app_bar.dart';

class GradientBackgroundScreen extends ConsumerStatefulWidget {
  const GradientBackgroundScreen({super.key});

  @override
  ConsumerState<GradientBackgroundScreen> createState() => _GradientBackgroundScreenState();
}

class _GradientBackgroundScreenState extends ConsumerState<GradientBackgroundScreen> with PlayerStateMixin, PlayerEventMixin {
  late YoutubePlayerController _controller;
  final ScrollController _scrollController = ScrollController();
  String _previousVideoId = '';

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        mute: false,
        enableCaption: false,
        showControls: false,
        showFullscreenButton: false,
        showVideoAnnotations: false,
        loop: false,
        origin: 'https://www.youtube-nocookie.com',
      ),
    );

    // _scrollController.addListener(_snapHeader);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.videoStateStream.listen((state) {
        final second = state.position.inSeconds;
        ref.read(playerCurrentSecondsProvider.notifier).change(second);
      });

      _controller.listen((value) {
        final currentVideoId = value.metaData.videoId;

        if (currentVideoId != _previousVideoId) {
          _previousVideoId = currentVideoId;
          changeSelectedItemById(ref, currentVideoId);
        }
      });
    });
  }

  @override
  void dispose() {
    ref.invalidate(playerCurrentSecondsProvider);
    _scrollController.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final safeAreaHeight = context.safeAreaHeight;

    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        backgroundColor: const Color(0xFF121717),
        body: Stack(
          children: [
            /// gradient background
            const GradientBackgroundWidget(),

            /// main body
            SafeArea(
              child: Column(
                children: [
                  PlaylistAppBar(
                    isLogoWhite: isLogoWhite(ref),
                  ),
                  Expanded(
                    child: (isSelected(ref)) ? NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.depth == 0) {
                          _snapHeader(safeAreaHeight);
                        }
                        return false;
                      },
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          SliverPersistentHeader(
                            pinned: true,
                            floating: false,
                            delegate: ExpandingPlayerHeaderDelegate(
                              maxHeight: safeAreaHeight - PlaylistAppBar.height,
                              onTap: (index) => _scrollTo(index, safeAreaHeight: safeAreaHeight),
                            ),
                          ),
                        ],
                        body: Padding(
                          padding: const EdgeInsets.only(top: 72),
                          child: const PlaylistPage(),
                        ),
                      ),
                    ) : const PlaylistPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollTo(int index, {required double safeAreaHeight}) {
    const itemHeight = 88;
    final totalScreenShowingIndex = safeAreaHeight ~/ itemHeight;
    final scrollIndex = math.max(index - totalScreenShowingIndex + 2, 0);

    _scrollController.animateTo(
      safeAreaHeight + (scrollIndex * itemHeight),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _snapHeader(double maxHeaderHeight) {
    if (!_scrollController.hasClients) return;

    final double currentOffset = _scrollController.offset;

    // ExpandingPlayerHeaderDelegate의 maxHeight, minHeight를 알아야 합니다.
    // delegate에 minHeight를 추가하는 것을 강력 추천합니다.
    const double minHeaderHeight = 72/* delegate의 minExtent, 예: 80.0 또는 kToolbarHeight */;

    final double headerRange = maxHeaderHeight - minHeaderHeight;

    // 현재 헤더가 얼마나 펼쳐져 있는지 (0.0 ~ headerRange)
    // NestedScrollView에서는 outer scroll offset이 header 영역을 포함합니다.
    final double headerVisibleExtent = (maxHeaderHeight - currentOffset).clamp(0.0, headerRange);
    print('headerVisibleExtent = $headerVisibleExtent');

    final bool shouldExpand = headerVisibleExtent > headerRange / 2;

    final double targetOffset = shouldExpand
        ? 0.0                                      // 최대 확장 (offset 0)
        : maxHeaderHeight - minHeaderHeight;       // 최소 축소 (header가 minHeight만큼만 보이게)

    // 부드러운 애니메이션으로 snap
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }
}