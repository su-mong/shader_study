import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaylistAppBar extends StatelessWidget {
  static const double height = 56;

  final String logo;
  final bool isWhite;
  final VoidCallback toggle;

  const PlaylistAppBar({
    super.key,
    required this.logo,
    required this.isWhite,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BackButton(
                  color: isWhite ? const Color(0xFFFFFFFF) : const Color(0xFF121717),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: toggle,
              child: Image.asset(
                logo,
                height: 24,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}