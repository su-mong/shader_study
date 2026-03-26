import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MusicPlayerShowPlaylistWidget extends StatelessWidget {
  final bool isWhite;
  final VoidCallback? onTap;

  const MusicPlayerShowPlaylistWidget({
    super.key,
    required this.isWhite,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/navigate_next.svg',
            width: 24,
            height: 24,
            color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
          ),
          Text(
            '클릭해서 플레이리스트 보기',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 21 / 14,
              letterSpacing: 0,
              color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
            ),
          ),
          SvgPicture.asset(
            'assets/images/navigate_next.svg',
            width: 24,
            height: 24,
            color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
          ),
        ],
      ),
    );
  }
}