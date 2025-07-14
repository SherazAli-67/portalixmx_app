class ComplaintsResponse {
  final String message;
  final bool status;
  final List<Complaint> data;

  ComplaintsResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ComplaintsResponse.fromJson(Map<String, dynamic> json) {
    return ComplaintsResponse(
      message: json['message'],
      status: json['status'],
      data: List<Complaint>.from(json['data'].map((x) => Complaint.fromJson(x))),
    );
  }
}

class Complaint {
  final String id;
  final String complaintId;
  final String status;
  final String complaint;
  final List<String> images;
  final String createdBy;
  final bool isRemoved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Complaint({
    required this.id,
    required this.complaintId,
    required this.status,
    required this.complaint,
    required this.images,
    required this.createdBy,
    required this.isRemoved,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['_id'],
      complaintId: json['complaintId'],
      status: json['status'],
      complaint: json['complaint'],
      images: List<String>.from(json['images']),
      createdBy: json['createdBy'],
      isRemoved: json['isRemoved'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}