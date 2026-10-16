import 'package:flutter/foundation.dart';

import '../../../core/constants/app_assets.dart';
import '../../booking/data/models/booking_flow_args.dart';

class TicketStore {
  TicketStore._() {
    tickets.value = [_demoUpcoming, _demoPast];
  }

  static final TicketStore instance = TicketStore._();

  final ValueNotifier<List<BookingFlowArgs>> tickets =
      ValueNotifier<List<BookingFlowArgs>>(<BookingFlowArgs>[]);

  void add(BookingFlowArgs booking) {
    tickets.value = [booking, ...tickets.value];
  }

  static BookingFlowArgs get _demoUpcoming => BookingFlowArgs(
        team1: 'Pakistan',
        team2: 'New Zealand',
        format: 'ODI',
        venue: 'Rawalpindi Cricket Stadium',
        dateTime: DateTime.now().add(const Duration(hours: 5, minutes: 20)),
        matchImageAsset: AppAssets.stadiumSplash,
        enclosureId: 'general',
        ticketCount: 1,
        gate: '3',
        orderId: 'PCB784562',
      );

  static BookingFlowArgs get _demoPast => BookingFlowArgs(
        team1: 'Pakistan',
        team2: 'England',
        format: 'T20I',
        venue: 'Gaddafi Stadium, Lahore',
        dateTime: DateTime.now().subtract(const Duration(days: 6)),
        matchImageAsset: AppAssets.featuredBanner1,
        enclosureId: 'premium',
        ticketCount: 2,
        gate: '1',
        orderId: 'PCB551902',
      );
}
