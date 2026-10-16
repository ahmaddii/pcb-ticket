import 'package:flutter/material.dart';

import '../../../core/router/route_names.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/widgets/dark_page.dart';
import '../../booking/data/models/booking_flow_args.dart';
import '../../tickets/data/ticket_store.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DarkPage(
      title: 'Booking History',
      child: ValueListenableBuilder<List<BookingFlowArgs>>(
        valueListenable: TicketStore.instance.tickets,
        builder: (context, tickets, _) {
          if (tickets.isEmpty) {
            return const Center(
              child: Text(
                'No bookings yet.',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            itemCount: tickets.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    RouteNames.ticketDetails,
                    arguments: ticket.toMap(),
                  );
                },
                tileColor: const Color(0xFF0F1C18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFF24332D)),
                ),
                title: Text(
                  '${ticket.team1} vs ${ticket.team2}',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${ticket.enclosure.name}  ·  ${DateFormatter.formatMatchLine(ticket.dateTime)}',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Colors.white38),
              );
            },
          );
        },
      ),
    );
  }
}
