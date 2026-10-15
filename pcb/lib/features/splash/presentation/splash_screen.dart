import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _navigationTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();

    // Transition to Onboarding after 2.6 seconds
    _navigationTimer = Timer(const Duration(milliseconds: 2600), _goToOnboarding);
  }

  void _goToOnboarding() {
    if (!mounted || _navigated) return;
    _navigated = true;
    _navigationTimer?.cancel();

    Navigator.of(context).pushReplacementNamed(RouteNames.onboarding);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _goToOnboarding, // Tap anywhere to skip immediately
      child: Scaffold(
        backgroundColor: const Color(0xFF020E0A),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Full-screen Stadium Background
            Image.asset(
              AppAssets.stadiumSplash,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFF020E0A));
              },
            ),

            // 2. Seamless dark gradient overlay (smooth dark atmospheric tone)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.38, 0.72, 1.0],
                  colors: [
                    const Color(0xFF020E0A),
                    const Color(0xFF031610).withValues(alpha: 0.92),
                    const Color(0xFF031610).withValues(alpha: 0.45),
                    const Color(0xFF010806).withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),

            // 3. Center Content: Star Logo, Framed PCB with lines, and Motto (clean, no glow)
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.10),

                        // Golden Star PCB Calligraphy Logo
                        Image.asset(
                          AppAssets.splashLogo,
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.star,
                              size: 100,
                              color: Color(0xFFC5A358),
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        // Upper framing horizontal line
                        Container(
                          width: 120,
                          height: 1.4,
                          color: const Color(0xFF7A9688).withValues(alpha: 0.85),
                        ),
                        const SizedBox(height: 6),

                        // PCB Header - Crisp, clean, no blur or glow
                        const Text(
                          'PCB',
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 4.5,
                            color: Colors.white,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Lower framing horizontal line
                        Container(
                          width: 120,
                          height: 1.4,
                          color: const Color(0xFF7A9688).withValues(alpha: 0.85),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle: Pakistan Cricket Board - Crisp, no blur or glow
                        Text(
                          'Pakistan Cricket Board',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.5,
                            color: Colors.white.withValues(alpha: 0.94),
                          ),
                        ),
                        const SizedBox(height: 42),

                        // Tagline: "Cricket for Everyone" - Crisp, no blur or glow
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Cricket ',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                  color: Color(0xFF34D399),
                                ),
                              ),
                              TextSpan(
                                text: 'for Everyone',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.4,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
    );
  }
}
