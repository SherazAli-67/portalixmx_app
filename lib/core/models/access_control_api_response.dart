class AccessRequestControlApiResponse {
  final String message;
  final bool status;
  final List<AccessRequestModel> data;

  AccessRequestControlApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory AccessRequestControlApiResponse.fromJson(Map<String, dynamic> json) {
    return AccessRequestControlApiResponse(
      message: json['message'],
      status: json['status'],
      data: List<AccessRequestModel>.from(json['data'].map((x) => AccessRequestModel.fromJson(x))),
    );
  }
}

class AccessRequestModel {
  final String id;
  final String name;
  final String image;
  final String createdBy;
  final List<Access> access;

  AccessRequestModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createdBy,
    required this.access,
  });

  factory AccessRequestModel.fromJson(Map<String, dynamic> json) {
    return AccessRequestModel(
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