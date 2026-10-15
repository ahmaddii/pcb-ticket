class ScanResultModel {
  final bool isValid;
  final String ticketId;
  final String message;
  final DateTime timestamp;

  const ScanResultModel({
    required this.isValid,
    required this.ticketId,
    required this.message,
    required this.timestamp,
  });

  factory ScanResultModel.fromJson(Map<String, dynamic> json) {
    return ScanResultModel(
      isValid: json['isValid'] as bool? ?? false,
      ticketId: json['ticketId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      timestamp: DateTime.tryParse(json['timestamp'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'isValid': isValid,
    'ticketId': ticketId,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}
