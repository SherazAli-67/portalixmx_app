class SocietyModel {
  final String id;
  final String name;
  final String? location;
  final String? residentAdmin;
  final String status;

  SocietyModel({
    required this.id,
    required this.name,
    this.location,
    this.residentAdmin,
    required this.status,
  });

  factory SocietyModel.fromMap(Map<String, dynamic> map) {
    return SocietyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'],
      residentAdmin: map['residentAdmin'],
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'residentAdmin': residentAdmin,
      'status': status,
    };
  }

  SocietyModel copyWith({
    String? id,
    String? name,
    String? location,
    String? residentAdmin,
    String? status,
  }) {
    return SocietyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      residentAdmin: residentAdmin ?? this.residentAdmin,
      status: status ?? this.status,
    );
  }
}