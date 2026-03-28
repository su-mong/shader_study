import 'dart:async';
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
  StreamSubscription? _videoStateSubscription;
  StreamSubscription? _controllerSubscription;
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
      _videoStateSubscription = _controller.videoStateStream.listen((state) {
        if (!mounted) return;
        final second = state.position.inSeconds;
        ref.read(playerCurrentSecondsProvider.notifier).change(second);
      });

      _controllerSubscription = _controller.listen((value) {
        if (!mounted) return;
        final currentVideoId = value.metaData.videoId;

        if (currentVideoId != _previousVideoId) {
          _previousVideoId = currentVideoId;
          changeSelectedItemById(ref, currentVideoId);
        }
      });
    });
  }

  @override
  void deactivate() {
    ref.invalidate(playerCurrentSecondsProvider);
    super.deactivate();
  }

  @override
  void dispose() {
    _videoStateSubscription?.cancel();
    _controllerSubscription?.cancel();
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
                        if (notification.depth == 1) {
                          _snapHeader(safeAreaHeight - PlaylistAppBar.height);
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

    const double minHeaderHeight = 56;

    final double headerRange = maxHeaderHeight - minHeaderHeight;

    if(currentOffset >= headerRange) {
      return;
    }

    final bool shouldExpand = currentOffset < headerRange / 2;
    final double targetOffset = shouldExpand ? 0 : maxHeaderHeight;

    // 부드러운 애니메이션으로 snap
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }
}