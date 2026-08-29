enum UserStatus {
  pending,
  approved,
}
UserStatus _userStatusFromMap(dynamic raw) {
  if (raw == null) return UserStatus.pending;
  final idx = raw is int ? raw : int.tryParse(raw.toString());
  if (idx == null || idx < 0 || idx >= UserStatus.values.length) {
    return UserStatus.pending;
  }
  return UserStatus.values[idx];
}
class UserModel {
  final String userID;
  final String userName;
  final String email;
  final String? phoneNum;
  final DateTime createdAt;
  final String? profileImg;
  final VehicleInformation? vehicleInformation;
  final String? societyID;
  final UserStatus status;
  final List<String> emergencyContacts;
  final String? zkPin;
  final DateTime? zkProvisionedAt;
  final List<String> zkAccLevelIds;

  UserModel({
    required this.userID,
    required this.userName,
    required this.email,
    required this.createdAt,
    this.profileImg,
    this.phoneNum,
    this.societyID,
    this.vehicleInformation,
    this.emergencyContacts = const [],
    this.status = UserStatus.pending,
    this.zkPin,
    this.zkProvisionedAt,
    this.zkAccLevelIds = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'emailAddress': email,
      'phoneNum' : phoneNum,
      'societyID': societyID,
      'createdAt': createdAt.toIso8601String(),
      'profileImg': profileImg,
      'vehicleInformation': vehicleInformation?.toMap(),
      'emergencyContacts': emergencyContacts,
      'status': status.index,
      'zkPin': zkPin,
      'zkProvisionedAt': zkProvisionedAt?.toIso8601String(),
      'zkAccLevelIds': zkAccLevelIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '',
      userName: map['userName'] ?? '',
      email: map['emailAddress'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      profileImg: map['profileImg'],
      phoneNum: map['phoneNum'],
      societyID: map['societyID'],
      vehicleInformation: map['vehicleInformation'] != null
          ? VehicleInformation.fromMap(
          Map<String, dynamic>.from(map['vehicleInformation']))
          : null,
      emergencyContacts: map['emergencyContacts'] != null
          ? List<String>.from(map['emergencyContacts'])
          : [],

      status: _userStatusFromMap(map['status']),
      zkPin: map['zkPin'],
      zkProvisionedAt: map['zkProvisionedAt'] != null
          ? DateTime.tryParse(map['zkProvisionedAt'].toString())
          : null,
      zkAccLevelIds: map['zkAccLevelIds'] != null
          ? List<String>.from(map['zkAccLevelIds'])
          : [],
    );
  }

  bool get isApproved => status == UserStatus.approved;

  bool get hasZkAccess => zkPin != null && zkPin!.isNotEmpty;

  UserModel copyWith({
    String? userID,
    String? userName,
    String? email,
    DateTime? createdAt,
    String? profileImg,
    String? phoneNum,
    String? societyID,
    UserStatus? status,
    VehicleInformation? vehicleInformation,
    List<String>? emergencyContacts,
    String? zkPin,
    DateTime? zkProvisionedAt,
    List<String>? zkAccLevelIds,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      profileImg: profileImg ?? this.profileImg,
      phoneNum: phoneNum ?? this.phoneNum,
      societyID: societyID ?? this.societyID,
      vehicleInformation:
      vehicleInformation ?? this.vehicleInformation,
      emergencyContacts:
      emergencyContacts ?? this.emergencyContacts,
      status: status ?? this.status,
      zkPin: zkPin ?? this.zkPin,
      zkProvisionedAt: zkProvisionedAt ?? this.zkProvisionedAt,
      zkAccLevelIds: zkAccLevelIds ?? this.zkAccLevelIds,
    );
  }
}


class VehicleInformation {
  final String name;
  final String color;
  final String licensePlateNumber;
  final String registrationNumber;

  VehicleInformation({
    required this.name,
    required this.color,
    required this.registrationNumber,
    required this.licensePlateNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color,
      'licensePlateNumber': licensePlateNumber,
      'registrationNumber': registrationNumber,
    };
  }

  factory VehicleInformation.fromMap(Map<String, dynamic> map) {
    return VehicleInformation(
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      licensePlateNumber: map['licensePlateNumber'] ?? '',
      registrationNumber: map['registrationNumber'] ?? '',
    );
  }

  VehicleInformation copyWith({
    String? name,
    String? color,
    String? licensePlateNumber,
    String? registrationNumber,
  }) {
    return VehicleInformation(
      name: name ?? this.name,
      color: color ?? this.color,
      licensePlateNumber:
      licensePlateNumber ?? this.licensePlateNumber,
      registrationNumber:
      registrationNumber ?? this.registrationNumber,
    );
  }
}