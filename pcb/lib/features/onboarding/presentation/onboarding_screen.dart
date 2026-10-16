import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';
import 'widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlideData> _slides = const [
    OnboardingSlideData(
      title: 'Experience\nLive Cricket\nLike Never Before',
      description:
          'Book your tickets, choose your preferred enclosure and be part of the action.',
      imagePath: AppAssets.onboarding1,
    ),
    OnboardingSlideData(
      title: 'Select Seats &\nExclusive Enclosures\nInteractive Map',
      description:
          'Explore interactive stadium layouts, compare VIP amenities, and secure the best vantage point.',
      imagePath: AppAssets.onboarding2,
    ),
    OnboardingSlideData(
      title: 'Instant Digital Tickets\n& Fast Gate Access',
      description:
          'Skip the long queues. Scan your secure digital QR code directly from your phone at stadium turnstiles.',
      imagePath: AppAssets.onboarding3,
    ),
  ];

  void _onGetStartedPressed() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Navigator.of(context).pushNamed(RouteNames.register);
    }
  }

  void _onLoginPressed() {
    Navigator.of(context).pushNamed(RouteNames.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageHeight = size.height * 0.44;

    return Scaffold(
      backgroundColor: const Color(0xFF03140F),
      body: Stack(
        children: [
          // 1. Full Screen Layout with Swipable Upper Content & Fixed Bottom Bar
          Column(
            children: [
              // Swipable Image & Text area
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingSlide(
                      data: _slides[index],
                      imageHeight: imageHeight,
                    );
                  },
                ),
              ),

              // 2. Fixed Bottom Area (Dots + Buttons) strictly separated from text
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Indicator Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_slides.length, (index) {
                          final isActive = index == _currentPage;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            width: isActive ? 22 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFF00C853)
                                  : const Color(0xFF244437),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // "Get Started" Filled Primary Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _onGetStartedPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C853),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _currentPage < _slides.length - 1
                                    ? 'Next'
                                    : 'Get Started',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              if (_currentPage < _slides.length - 1) ...[
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 18),
                              ],
                            ],
                          ),
                        ),
                      ),
                      // "Login" Outlined Secondary Button (only on the last onboard screen)
                      AnimatedCrossFade(
                        firstChild: const SizedBox(
                          width: double.infinity,
                          height: 0,
                        ),
                        secondChild: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: OutlinedButton(
                              onPressed: _onLoginPressed,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Color(0xFF00C853),
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        crossFadeState: _currentPage == _slides.length - 1
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 280),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. Top Skip Button
          Positioned(
            top: 0,
            right: 16,
            child: SafeArea(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteNames.login);
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
