import '../../../enclosure/data/enclosure_catalog.dart';

class BookingFlowArgs {
  final String team1;
  final String team2;
  final String format;
  final String venue;
  final DateTime dateTime;
  final String matchImageAsset;
  final String enclosureId;
  final int ticketCount;
  final String gate;
  final String? orderId;

  const BookingFlowArgs({
    required this.team1,
    required this.team2,
    required this.format,
    required this.venue,
    required this.dateTime,
    required this.matchImageAsset,
    required this.enclosureId,
    this.ticketCount = 1,
    this.gate = '3',
    this.orderId,
  });

  EnclosureOption get enclosure => EnclosureCatalog.byId(enclosureId);

  double get subtotal => enclosure.price * ticketCount;

  double get serviceFee => 50;

  double get total => subtotal + serviceFee;

  BookingFlowArgs copyWith({
    String? enclosureId,
    int? ticketCount,
    String? gate,
    String? orderId,
  }) {
    return BookingFlowArgs(
      team1: team1,
      team2: team2,
      format: format,
      venue: venue,
      dateTime: dateTime,
      matchImageAsset: matchImageAsset,
      enclosureId: enclosureId ?? this.enclosureId,
      ticketCount: ticketCount ?? this.ticketCount,
      gate: gate ?? this.gate,
      orderId: orderId ?? this.orderId,
    );
  }

  factory BookingFlowArgs.fromMap(Object? arguments) {
    final map = arguments as Map<String, dynamic>?;
    return BookingFlowArgs(
      team1: map?['team1'] as String? ?? 'Pakistan',
      team2: map?['team2'] as String? ?? 'New Zealand',
      format: map?['format'] as String? ?? 'ODI',
      venue: map?['venue'] as String? ?? 'Rawalpindi Cricket Stadium',
      dateTime: map?['dateTime'] as DateTime? ??
          DateTime.now().add(const Duration(hours: 5, minutes: 20)),
      matchImageAsset: map?['matchImageAsset'] as String? ??
          map?['imageAsset'] as String? ??
          'assets/images/stadium_splash.jpg',
      enclosureId: map?['enclosureId'] as String? ?? 'general',
      ticketCount: map?['ticketCount'] as int? ?? 1,
      gate: map?['gate'] as String? ?? '3',
      orderId: map?['orderId'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'team1': team1,
        'team2': team2,
        'format': format,
        'venue': venue,
        'dateTime': dateTime,
        'matchImageAsset': matchImageAsset,
        'imageAsset': matchImageAsset,
        'enclosureId': enclosureId,
        'ticketCount': ticketCount,
        'gate': gate,
        'orderId': orderId,
      };
}
