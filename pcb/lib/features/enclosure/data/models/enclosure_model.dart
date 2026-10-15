class EnclosureModel {
  final String id;
  final String name;
  final double price;
  final int totalSeats;
  final int availableSeats;

  const EnclosureModel({
    required this.id,
    required this.name,
    required this.price,
    required this.totalSeats,
    required this.availableSeats,
  });

  factory EnclosureModel.fromJson(Map<String, dynamic> json) {
    return EnclosureModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      totalSeats: json['totalSeats'] as int? ?? 0,
      availableSeats: json['availableSeats'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'totalSeats': totalSeats,
    'availableSeats': availableSeats,
  };
}
