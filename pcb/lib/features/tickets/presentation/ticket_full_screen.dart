import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/dark_back_button.dart';
import '../../booking/data/models/booking_flow_args.dart';
import 'widgets/ticket_qr.dart';

class TicketFullScreen extends StatelessWidget {
  final BookingFlowArgs booking;

  const TicketFullScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final enclosure = booking.enclosure;
    final orderId = booking.orderId ?? 'PCB784562';
    final enclosureShort = enclosure.name.replaceAll(' Enclosure', '');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF03140F),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Column(
              children: [
                const Row(
                  children: [
                    DarkBackButton(),
                    Expanded(
                      child: Text(
                        'Your Ticket',
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
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F1C18),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF24332D)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  booking.matchImageAsset,
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const SizedBox(
                                      width: 54,
                                      height: 54,
                                      child: ColoredBox(
                                        color: Color(0xFF141A18),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${booking.team1} vs ${booking.team2}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      '${booking.format}  ·  ${booking.venue}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.5),
                                        fontSize: 11,
                                      ),
                                    ),
                                    Text(
                                      DateFormatter.formatMatchLine(
                                        booking.dateTime,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white
                                            .withValues(alpha: 0.5),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          TicketQr(data: orderId, size: 210),
                          const SizedBox(height: 18),
                          Text(
                            enclosure.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${booking.ticketCount} Ticket',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Gate: ${booking.gate}  ·  Enclosure: $enclosureShort',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00C853),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Valid',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Show this QR code at the stadium gate',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 12,
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
