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
    with TickerProviderStateMixin {
  late final AnimationController _intro;
  late final AnimationController _bg;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _logoScale;
  Timer? _navigationTimer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _bg = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _intro, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));
    _logoScale = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _intro, curve: Curves.easeOutBack),
    );

    _intro.forward();
    _navigationTimer =
        Timer(const Duration(milliseconds: 2800), _goToOnboarding);
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
    _intro.dispose();
    _bg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _goToOnboarding,
      child: Scaffold(
        backgroundColor: const Color(0xFF020E0A),
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _bg,
              builder: (context, child) {
                final t = Curves.easeInOut.transform(_bg.value);
                return Transform.scale(
                  scale: 1.04 + t * 0.08,
                  child: child,
                );
              },
              child: Image.asset(
                AppAssets.stadiumSplash,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return const ColoredBox(color: Color(0xFF020E0A));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.32, 0.68, 1.0],
                  colors: [
                    const Color(0xFF020E0A),
                    const Color(0xFF031610).withValues(alpha: 0.88),
                    const Color(0xFF031610).withValues(alpha: 0.35),
                    const Color(0xFF010806).withValues(alpha: 0.94),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.09),
                      ScaleTransition(
                        scale: _logoScale,
                        child: Image.asset(
                          AppAssets.splashLogo,
                          width: 128,
                          height: 128,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.star,
                              size: 100,
                              color: Color(0xFFC5A358),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: 86,
                        height: 1.4,
                        color: const Color(0xFF7A9688).withValues(alpha: 0.85),
                      ),
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      Container(
                        width: 86,
                        height: 1.4,
                        color: const Color(0xFF7A9688).withValues(alpha: 0.85),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pakistan Cricket Board',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5,
                          color: Colors.white.withValues(alpha: 0.94),
                        ),
                      ),
                      const SizedBox(height: 36),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Cricket ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF34D399),
                              ),
                            ),
                            TextSpan(
                              text: 'for Everyone',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const _SplashLoader(),
                      const SizedBox(height: 10),
                      Text(
                        'Official match ticketing',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.55),
                          fontSize: 12,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to continue',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.35),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
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

class _SplashLoader extends StatefulWidget {
  const _SplashLoader();

  @override
  State<_SplashLoader> createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<_SplashLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final t = (_controller.value + index * 0.2) % 1.0;
            final scale = 0.7 + (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0) * 0.5;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 7 * scale,
              height: 7 * scale,
              decoration: const BoxDecoration(
                color: Color(0xFF00C853),
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
