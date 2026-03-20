import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlaylistAppBar extends StatelessWidget {
  final bool isLogoWhite;

  const PlaylistAppBar({
    super.key,
    required this.isLogoWhite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(left: 20),
                child: BackButton(
                  color: const Color(0xFFFFFFFF),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Image.asset(
              isLogoWhite ? 'assets/images/logo_white.png' : 'assets/images/logo_black.png',
              height: 24,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}