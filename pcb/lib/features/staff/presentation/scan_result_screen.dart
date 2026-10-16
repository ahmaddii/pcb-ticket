import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../booking/data/models/booking_flow_args.dart';

class ScanResultScreen extends StatelessWidget {
  final BookingFlowArgs booking;

  const ScanResultScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final enclosure = booking.enclosure;
    final enclosureShort = enclosure.name.replaceAll(' Enclosure', '');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C853),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Entry Approved',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome to ${booking.venue}!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.55),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1C18),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFF24332D)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: enclosure.color.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.event_seat_rounded,
                              color: enclosure.color,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  enclosure.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Gate ${booking.gate}  ·  Enclosure: $enclosureShort',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xFF00C853),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormatter.formatMatchLine(booking.dateTime),
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GreenCtaButton(
                  label: 'Next Fan',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      RouteNames.scanner,
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: Color(0xFF00C853),
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Fan Entry Recorded',
                      style: TextStyle(
                        color: Color(0xFF00C853),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
