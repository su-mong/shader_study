import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicPlayerInfoWidget extends StatelessWidget {
  final String artistImage;
  final String artistName;
  final String title;
  final String albumName;
  final Color textColor;
  final bool isFavorite;

  const MusicPlayerInfoWidget({
    super.key,
    required this.artistImage,
    required this.artistName,
    required this.title,
    required this.albumName,
    required this.textColor,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 4,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/$artistImage',
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Text(
                artistName,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  letterSpacing: 0,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          spacing: 12,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  letterSpacing: 0,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/images/icon_heart.svg',
                width: 24,
                height: 24,
                color: isFavorite ? const Color(0xFFFFFFFF) : const Color(0x6FFFFFFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          albumName,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            letterSpacing: 0,
            color: textColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}