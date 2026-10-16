import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/router/route_names.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../tickets/data/ticket_store.dart';
import '../../tickets/presentation/widgets/ticket_qr.dart';
import 'widgets/scan_frame_overlay.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _laser;
  Timer? _scanTimer;

  @override
  void initState() {
    super.initState();
    _laser = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _scanTimer = Timer(const Duration(milliseconds: 2200), _completeScan);
  }

  void _completeScan() {
    if (!mounted) return;
    final tickets = TicketStore.instance.tickets.value;
    final ticket = tickets.isNotEmpty ? tickets.first : null;
    Navigator.of(context).pushReplacementNamed(
      RouteNames.scanResult,
      arguments: ticket?.toMap(),
    );
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _laser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.stadiumSplash,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(color: Color(0xFF03140F));
              },
            ),
            const ColoredBox(color: Color(0xCC03140F)),
            SafeArea(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Row(
                      children: [
                        DarkBackButton(),
                        Expanded(
                          child: Text(
                            'Scan Ticket',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 268,
                    height: 268,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        TicketQr(data: 'SCAN-PREVIEW', size: 188),
                        const ScanFrameOverlay(size: 268),
                        AnimatedBuilder(
                          animation: _laser,
                          builder: (context, child) {
                            return Positioned(
                              top: 24 + _laser.value * 220,
                              left: 22,
                              right: 22,
                              child: Container(
                                height: 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00C853),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF00C853)
                                          .withValues(alpha: 0.7),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'Scanning...',
                    style: TextStyle(
                      color: Color(0xFF00C853),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Keep the QR code within the frame',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
