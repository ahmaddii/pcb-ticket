import 'package:flutter/material.dart';

class OnboardingSlideData {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingSlideData({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingSlide extends StatelessWidget {
  final OnboardingSlideData data;
  final double imageHeight;

  const OnboardingSlide({
    super.key,
    required this.data,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top stadium image with smooth gradient blend
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                data.imagePath,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF06231A),
                    child: const Icon(
                      Icons.stadium,
                      size: 80,
                      color: Color(0xFF00C853),
                    ),
                  );
                },
              ),
              // Gradient fade at bottom of image into background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.45, 0.85, 1.0],
                    colors: [
                      Colors.black.withValues(alpha: 0.25),
                      Colors.transparent,
                      const Color(0xFF03140F).withValues(alpha: 0.85),
                      const Color(0xFF03140F),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Title & Description text in available space
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1.18,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  data.description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 16.5,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
