import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../booking/data/models/booking_flow_args.dart';

class EnclosureDetailsScreen extends StatelessWidget {
  final BookingFlowArgs booking;

  const EnclosureDetailsScreen({
    super.key,
    required this.booking,
  });

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
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.45),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const DarkBackButton(),
                                ),
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
                          const _Chip(label: 'General Admission', filled: true),
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
                              icon: Icons.door_front_door_outlined,
                              title: enclosure.gateLabel,
                              subtitle: '${enclosure.distanceFromGate} walk',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Enclosure Amenities & Facilities',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _AmenitiesSection(
                        standType: enclosure.standType,
                        seatingType: enclosure.seatingType,
                        distance: enclosure.distanceFromGate,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        'Matchday Guidelines',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const _GuidelinesCard(),
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

class _AmenitiesSection extends StatelessWidget {
  final String standType;
  final String seatingType;
  final String distance;

  const _AmenitiesSection({
    required this.standType,
    required this.seatingType,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.stadium_outlined,
        title: standType,
        subtitle: 'Direct stadium pitch sightline',
      ),
      (
        icon: Icons.chair_outlined,
        title: seatingType,
        subtitle: 'Official numbered stadium seating',
      ),
      (
        icon: Icons.fastfood_outlined,
        title: 'Food & Refreshments',
        subtitle: 'Designated concourse food stalls',
      ),
      (
        icon: Icons.local_hospital_outlined,
        title: 'Medical & First Aid',
        subtitle: 'First aid post located near gate entry',
      ),
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0A1813),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF1B2E25)),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  item.icon,
                  color: const Color(0xFF00C853),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
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
      }).toList(),
    );
  }
}

class _GuidelinesCard extends StatelessWidget {
  const _GuidelinesCard();

  @override
  Widget build(BuildContext context) {
    final points = [
      'Original CNIC / Photo ID is mandatory for stadium entry.',
      'Gates open 2 hours prior to scheduled match toss.',
      'Show digital QR ticket on your phone at turnstiles.',
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1C18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF24332D)),
      ),
      child: Column(
        children: points.map((point) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 4, right: 8),
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    color: Color(0xFF00C853),
                    size: 15,
                  ),
                ),
                Expanded(
                  child: Text(
                    point,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
