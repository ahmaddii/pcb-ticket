class TicketModel {
  final String id;
  final String matchName;
  final String enclosureName;
  final String seatNumber;
  final String qrCodeData;
  final DateTime matchDate;

  const TicketModel({
    required this.id,
    required this.matchName,
    required this.enclosureName,
    required this.seatNumber,
    required this.qrCodeData,
    required this.matchDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String? ?? '',
      matchName: json['matchName'] as String? ?? '',
      enclosureName: json['enclosureName'] as String? ?? '',
      seatNumber: json['seatNumber'] as String? ?? '',
      qrCodeData: json['qrCodeData'] as String? ?? '',
      matchDate: DateTime.tryParse(json['matchDate'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'matchName': matchName,
    'enclosureName': enclosureName,
    'seatNumber': seatNumber,
    'qrCodeData': qrCodeData,
    'matchDate': matchDate.toIso8601String(),
  };
}
