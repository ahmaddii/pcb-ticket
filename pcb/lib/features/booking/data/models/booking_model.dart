class BookingModel {
  final String id;
  final String matchId;
  final String enclosureId;
  final int ticketCount;
  final double totalAmount;

  const BookingModel({
    required this.id,
    required this.matchId,
    required this.enclosureId,
    required this.ticketCount,
    required this.totalAmount,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String? ?? '',
      matchId: json['matchId'] as String? ?? '',
      enclosureId: json['enclosureId'] as String? ?? '',
      ticketCount: json['ticketCount'] as int? ?? 1,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'matchId': matchId,
    'enclosureId': enclosureId,
    'ticketCount': ticketCount,
    'totalAmount': totalAmount,
  };
}
