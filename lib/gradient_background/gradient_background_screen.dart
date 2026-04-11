import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shader_study/shader_mask/glitch_shader_painter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../utils/context_extension.dart';
import 'mixin/player_event_mixin.dart';
import 'mixin/player_state_mixin.dart';
import 'model/playlist_model.dart';
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

class _GradientBackgroundScreenState extends ConsumerState<GradientBackgroundScreen>
    with PlayerStateMixin, PlayerEventMixin, TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<NestedScrollViewState> _nestedScrollViewKey = GlobalKey<NestedScrollViewState>();
  StreamSubscription? _videoStateSubscription;
  StreamSubscription? _controllerSubscription;
  String _previousVideoId = '';

  bool _canToggle = true;

  /// for glitch transition
  ui.FragmentShader? _shader;
  Ticker? _ticker;
  double _time = 0;
  ui.Image? _cardImage;
  final _boundaryKey = GlobalKey();
  bool _glitching = false;

  @override
  void initState() {
    super.initState();

    _loadShader();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _videoStateSubscription = _controller.videoStateStream.listen((state) {
        if (!mounted) return;
        final second = state.position.inSeconds;
        ref.read(playerCurrentSecondsProvider.notifier).change(second);
      });

      _controllerSubscription = _controller.listen((value) {
        if (!mounted) return;
        final currentVideoId = value.metaData.videoId;

        _canToggle = switch(value.playerState) {
          PlayerState.unknown => true,
          PlayerState.ended => true,
          PlayerState.paused => true,
          PlayerState.cued => false,
          PlayerState.unStarted => false,
          PlayerState.buffering => false,
          PlayerState.playing => false,
        };

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
    _ticker?.dispose();
    _cardImage?.dispose();
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
            RepaintBoundary(
              key: _boundaryKey,
              child: SafeArea(
                child: Column(
                  children: [
                    PlaylistAppBar(
                      isWhite: isLogoWhite(ref),
                      toggle: () => _startToggle(context),
                      logo: playlistType(ref) == PlaylistType.stellive
                          ? isLogoWhite(ref) ? 'assets/images/stellive_logo_white_1.png' : 'assets/images/stellive_logo_black.png'
                          : isLogoWhite(ref) ? 'assets/images/logo_white.png' : 'assets/images/logo_black.png',
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
                          key: _nestedScrollViewKey,
                          controller: _scrollController,
                          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                            SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: ExpandingPlayerHeaderDelegate(
                                maxHeight: safeAreaHeight - PlaylistAppBar.height,
                                onTap: () => _scrollTo(
                                  selectedIndex(ref)!,
                                  safeAreaHeight: safeAreaHeight,
                                ),
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
            ),

            /// Glitch Transition
            if(_glitching)
              SizedBox(
                width: _cardImage!.width.toDouble(),
                height: _cardImage!.height.toDouble(),
                child: CustomPaint(
                  painter: GlitchShaderPainter(
                    shader: _shader!,
                    time: _time,
                    cardImage: _cardImage!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _scrollTo(int index, {required double safeAreaHeight}) {
    const itemHeight = 88;
    const minHeaderHeight = 72.0;
    const bodyTopPadding = 72.0;

    final maxHeaderHeight = safeAreaHeight - PlaylistAppBar.height;
    final headerScrollRange = maxHeaderHeight - minHeaderHeight;

    // 아이템이 보이도록 필요한 전체 스크롤 오프셋 계산
    final visibleBodyHeight = safeAreaHeight - PlaylistAppBar.height - minHeaderHeight - bodyTopPadding;
    final totalScreenShowingCount = visibleBodyHeight ~/ itemHeight;
    final scrollIndex = math.max(index - totalScreenShowingCount + 2, 0);
    final itemOffset = scrollIndex * itemHeight;

    // 1) outer controller: header를 완전히 접기
    _scrollController.animateTo(
      headerScrollRange,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // 2) inner controller: body 내 아이템 위치로 스크롤
    final innerController = _nestedScrollViewKey.currentState?.innerController;
    if (innerController != null && innerController.hasClients) {
      innerController.animateTo(
        itemOffset.toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
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

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/glitch_transition.frag');
    _shader = program.fragmentShader();
    setState(() {});
  }

  Future<void> _captureScreen() async {
    final boundary = _boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;

    final image = await boundary.toImage(pixelRatio: 2.0);
    setState(() {
      _cardImage = image;
    });
  }

  void _startToggle(BuildContext context) async {
    if(!_canToggle) {
      Fluttertoast.showToast(msg: '곡이 재생 중일 때는 플레이리스트를 교체할 수 없습니다.');
      return;
    }

    if (_glitching) return;
    _glitching = true;
    _time = 0;
    await _captureScreen();

    _ticker?.dispose();
    _ticker = createTicker((elapsed) {
      final t = elapsed.inMilliseconds / 1000.0;
      setState(() {
        _time = t;
      });

      // Reset after 1.5 seconds
      if (t > 1.5) {
        _ticker?.stop();
        setState(() {
          _time = 0;
          _glitching = false;
          _cardImage = null;
        });

        bool isSelected = toggleList(ref);
        if(isSelected) {
          _controller.loadPlaylist(
            list: playlist(ref).map((song) => song.id).toList(),
            index: 0,
          );
        }
      }
    })..start();
  }
}