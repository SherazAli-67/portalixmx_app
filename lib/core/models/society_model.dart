class SocietyModel {
  final String id;
  final String name;
  final String? location;
  final String? residentAdmin;
  final String status;
  final bool zkbioEnabled;
  final String? zkbioServerUrl;
  final int? zkbioServerPort;
  final List<String> defaultAccLevelIds;
  final List<String> defaultVisLevelIds;
  final Map<String, String> amenityAccLevelMap;

  SocietyModel({
    required this.id,
    required this.name,
    this.location,
    this.residentAdmin,
    required this.status,
    this.zkbioEnabled = false,
    this.zkbioServerUrl,
    this.zkbioServerPort,
    this.defaultAccLevelIds = const [],
    this.defaultVisLevelIds = const [],
    this.amenityAccLevelMap = const {},
  });

  factory SocietyModel.fromMap(Map<String, dynamic> map) {
    return SocietyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      location: map['location'],
      residentAdmin: map['residentAdmin'],
      status: map['status'] ?? '',
      zkbioEnabled: map['zkbioEnabled'] ?? false,
      zkbioServerUrl: map['zkbioServerUrl'],
      zkbioServerPort: map['zkbioServerPort'],
      defaultAccLevelIds: map['defaultAccLevelIds'] != null
          ? List<String>.from(map['defaultAccLevelIds'])
          : [],
      defaultVisLevelIds: map['defaultVisLevelIds'] != null
          ? List<String>.from(map['defaultVisLevelIds'])
          : [],
      amenityAccLevelMap: map['amenityAccLevelMap'] != null
          ? Map<String, String>.from(map['amenityAccLevelMap'])
          : {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'residentAdmin': residentAdmin,
      'status': status,
      'zkbioEnabled': zkbioEnabled,
      'zkbioServerUrl': zkbioServerUrl,
      'zkbioServerPort': zkbioServerPort,
      'defaultAccLevelIds': defaultAccLevelIds,
      'defaultVisLevelIds': defaultVisLevelIds,
      'amenityAccLevelMap': amenityAccLevelMap,
    };
  }

  SocietyModel copyWith({
    String? id,
    String? name,
    String? location,
    String? residentAdmin,
    String? status,
    bool? zkbioEnabled,
    String? zkbioServerUrl,
    int? zkbioServerPort,
    List<String>? defaultAccLevelIds,
    List<String>? defaultVisLevelIds,
    Map<String, String>? amenityAccLevelMap,
  }) {
    return SocietyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      residentAdmin: residentAdmin ?? this.residentAdmin,
      status: status ?? this.status,
      zkbioEnabled: zkbioEnabled ?? this.zkbioEnabled,
      zkbioServerUrl: zkbioServerUrl ?? this.zkbioServerUrl,
      zkbioServerPort: zkbioServerPort ?? this.zkbioServerPort,
      defaultAccLevelIds: defaultAccLevelIds ?? this.defaultAccLevelIds,
      defaultVisLevelIds: defaultVisLevelIds ?? this.defaultVisLevelIds,
      amenityAccLevelMap: amenityAccLevelMap ?? this.amenityAccLevelMap,
    );
  }
}