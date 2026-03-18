import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class TestimonialCard extends StatelessWidget {
  const TestimonialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 626 / 1200,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 626,
          height: 1200,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                // Decorative blob 1 (top-right area)
                Positioned(
                  left: 558 - 450,
                  top: 488 - 300,
                  child: Transform.rotate(
                    angle: pi,
                    child: Container(
                      width: 285,
                      height: 343,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(140),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF340073),
                            Color(0xFF360C9F),
                            Color(0xFFFFA28D),
                          ],
                          stops: [0.0, 0.496, 1.0],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.5),
                            blurRadius: 4,
                            spreadRadius: 6.7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Decorative blob 2 (bottom-left area)
                Positioned(
                  left: 100 - 450 + 450,
                  top: 1282 - 300 - 1200 + 1200,
                  child: Transform.rotate(
                    angle: pi,
                    child: Container(
                      width: 452,
                      height: 435,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF340073),
                            Color(0xFF360C9F),
                            Color(0xFFFFA28D),
                          ],
                          stops: [0.0, 0.496, 1.0],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.5),
                            blurRadius: 4,
                            spreadRadius: 6.7,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Decorative blob 3 (small, bottom-right)
                Positioned(
                  left: 415,
                  top: 1047 - 300,
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: Container(
                      width: 130,
                      height: 119,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFA28D),
                            Color(0xFF360C9F),
                            Color(0xFF340073),
                          ],
                          stops: [0.0, 0.504, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.5),
                            blurRadius: 4,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Glass card
                Positioned(
                  left: 46,
                  top: 89,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
                      child: Container(
                        width: 533,
                        height: 1022,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.5),
                              const Color(0xFF22111D).withValues(alpha: 0.5),
                            ],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Quote mark
                            Positioned(
                              left: 36,
                              top: 99 - 89,
                              child: Text(
                                '\u201C',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ),
                            // Quote text
                            Positioned(
                              left: 52,
                              top: 208 - 89,
                              child: SizedBox(
                                width: 430,
                                child: Text(
                                  'Propel let us spin up a new product in hours instead of weeks. It\u2019s exactly what we needed as a company that deeply values developer velocity and joy.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 49.8,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -1.5,
                                    height: 1.05,
                                  ),
                                ),
                              ),
                            ),
                            // Author
                            Positioned(
                              left: 43,
                              bottom: 100,
                              child: SizedBox(
                                width: 446,
                                child: Text(
                                  'DANIEL BRIGGS\nSR. DIRECTOR OF SALES, PINBOX',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
