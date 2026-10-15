class UserModel {
  final String id;
  final String phoneNumber;
  final String? name;

  const UserModel({
    required this.id,
    required this.phoneNumber,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'phoneNumber': phoneNumber,
    'name': name,
  };
}
