import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../booking/data/models/booking_flow_args.dart';
import 'widgets/panorama_viewer.dart';

class EnclosureDetailsScreen extends StatelessWidget {
  final BookingFlowArgs booking;

  const EnclosureDetailsScreen({
    super.key,
    required this.booking,
  });

  void _open360(BuildContext context) {
    final enclosure = booking.enclosure;
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => Enclosure360Screen(
          title: enclosure.name,
          imageAssets: enclosure.panoramaAssets,
          initialLook: 0.22,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final enclosure = booking.enclosure;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: SizedBox(
                          height: 210,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                enclosure.coverAsset,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const ColoredBox(
                                    color: Color(0xFF0F261E),
                                  );
                                },
                              ),
                              const Positioned(
                                top: 12,
                                left: 12,
                                child: DarkBackButton(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        enclosure.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF00C853),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              booking.venue,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.55),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        CurrencyFormatter.formatPKR(enclosure.price),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _Chip(label: 'General Admission', filled: true),
                          _Chip(label: enclosure.standType),
                          _Chip(label: enclosure.seatingType),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.event_seat_outlined,
                              title:
                                  '${CurrencyFormatter.withCommas(enclosure.availableSeats)}+',
                              subtitle: 'Available Capacity',
                              accent: enclosure.isLimited
                                  ? const Color(0xFFF3D03E)
                                  : const Color(0xFF00C853),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _InfoCard(
                              icon: Icons.directions_walk_rounded,
                              title: enclosure.distanceFromGate,
                              subtitle: 'From Main Gate',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'View from Enclosure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      EnclosurePanoramaViewer(
                        imageAssets: enclosure.panoramaAssets,
                        height: 220,
                        enableZoom: true,
                        showHint: true,
                        initialLook: 0.16,
                        onExpand: () => _open360(context),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: GreenCtaButton(
                  label: 'Book Now',
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      RouteNames.selectTickets,
                      arguments: booking.toMap(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool filled;

  const _Chip({required this.label, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: filled ? const Color(0xFF00C853) : const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: filled ? const Color(0xFF00C853) : const Color(0xFF24332D),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: filled ? Colors.white : Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? accent;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF24332D)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent ?? const Color(0xFF00C853), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: accent ?? Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
