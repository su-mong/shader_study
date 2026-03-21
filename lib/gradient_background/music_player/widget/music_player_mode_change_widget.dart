import 'package:flutter/material.dart';

class MusicPlayerModeChangeWidget extends StatelessWidget {
  const MusicPlayerModeChangeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 32,
      child: Stack(
        children: [
          Container(
            width: 128,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Container(
              width: 68,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0x99000000),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '노래',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 21 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.centerRight,
            child: Container(
              width: 68,
              height: 32,
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   color: const Color(0x99000000),
              //   borderRadius: BorderRadius.circular(16),
              // ),
              child: Text(
                '동영상',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 21 / 14,
                  letterSpacing: 0,
                  color: const Color(0xFF121717),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}