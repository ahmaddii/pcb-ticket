import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF041913),
      body: Stack(
        children: [
          // 1. Dark emerald gradient backdrop
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF051D16),
                    Color(0xFF07271E),
                    Color(0xFF03140F),
                  ],
                ),
              ),
            ),
          ),

          // 2. Stadium background at the bottom with smooth fading gradient
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height * 0.52,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.stadiumSplash,
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
                // Seamless top gradient blend
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.35, 0.75, 1.0],
                      colors: [
                        const Color(0xFF041913),
                        const Color(0xFF041913).withValues(alpha: 0.7),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Center/Top Content: Logo, PCB text, Lines, and Tagline
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
                      SizedBox(height: size.height * 0.08),

                      // Golden Star PCB Calligraphy Logo
                      Image.asset(
                        AppAssets.splashLogo,
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.star,
                            size: 90,
                            color: Color(0xFFC5A358),
                          );
                        },
                      ),
                      const SizedBox(height: 14),

                      // Upper decorative divider line
                      Container(
                        width: 130,
                        height: 1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              const Color(0xFFC5A358).withValues(alpha: 0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // PCB Header
                      const Text(
                        'PCB',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4.5,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Lower decorative divider line
                      Container(
                        width: 130,
                        height: 1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              const Color(0xFFC5A358).withValues(alpha: 0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Pakistan Cricket Board subtext
                      Text(
                        'Pakistan Cricket Board',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.4,
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // "Cricket for Everyone" Motto
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Cricket ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                                color: Color(0xFF38E1A0),
                              ),
                            ),
                            TextSpan(
                              text: 'for Everyone',
                              style: TextStyle(
                                fontSize: 22,
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
    );
  }
}
