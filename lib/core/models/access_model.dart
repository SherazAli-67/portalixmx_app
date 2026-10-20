class AccessModel {
  final String id;
  final String name;
  final String image;
  final String? societyID;

  AccessModel({
    required this.id,
    required this.name,
    required this.image,
    this.societyID,
  });

  factory AccessModel.fromJson(Map<String, dynamic> json) {
    return AccessModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      societyID: json['societyID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "image": image,
      if (societyID != null) "societyID": societyID,
    };
  }
}
