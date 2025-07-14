class AccessControlApiResponse {
  final String message;
  final bool status;
  final List<AccessModel> data;

  AccessControlApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AccessControlApiResponse.fromJson(Map<String, dynamic> json) {
    return AccessControlApiResponse(
      message: json['message'],
      status: json['status'],
      data: List<AccessModel>.from(json['data'].map((x) => AccessModel.fromJson(x))),
    );
  }
}

class AccessModel {
  final String id;
  final String name;
  final String image;
  final String createdBy;
  final List<Access> access;

  AccessModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdBy,
    required this.access,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) {
    return AccessModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      createdBy: json['createdBy'],
      access: List<Access>.from(json['access'].map((x) => Access.fromJson(x))),
    );
  }
}

class Access {
  final String userId;
  final String status;
  final DateTime timeStamp;
  final String id;

  Access({
    required this.userId,
    required this.status,
    required this.timeStamp,
    required this.id,
  });

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      userId: json['userId'],
      status: json['status'],
      timeStamp: DateTime.parse(json['timeStamp']),
      id: json['_id'],
    );
  }
}