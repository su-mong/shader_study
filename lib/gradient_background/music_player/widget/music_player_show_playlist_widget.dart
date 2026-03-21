import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MusicPlayerShowPlaylistWidget extends StatelessWidget {
  const MusicPlayerShowPlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/navigate_next.svg',
          width: 24,
          height: 24,
        ),
        Text(
          '클릭해서 플레이리스트 보기',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 21 / 14,
            letterSpacing: 0,
            color: const Color(0xFFFFFFFF),
          ),
        ),
        SvgPicture.asset(
          'assets/images/navigate_next.svg',
          width: 24,
          height: 24,
        ),
      ],
    );
  }
}