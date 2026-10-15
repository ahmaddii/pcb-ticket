class MatchModel {
  final String id;
  final String team1;
  final String team2;
  final String venue;
  final DateTime date;

  const MatchModel({
    required this.id,
    required this.team1,
    required this.team2,
    required this.venue,
    required this.date,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String? ?? '',
      team1: json['team1'] as String? ?? '',
      team2: json['team2'] as String? ?? '',
      venue: json['venue'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'team1': team1,
    'team2': team2,
    'venue': venue,
    'date': date.toIso8601String(),
  };
}
