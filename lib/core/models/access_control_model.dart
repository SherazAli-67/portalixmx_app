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
      message: json['message'] ?? '',
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => AccessModel.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "status": status,
      "data": data.map((item) => item.toJson()).toList(),
    };
  }
}

class AccessModel {
  final String id;
  final String? name;
  final String? image;

  AccessModel({
    required this.id,
    this.name,
    this.image,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) {
    return AccessModel(
      id: json['_id'] ?? '',
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "image": image,
    };
  }
}