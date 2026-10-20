import 'package:cloud_firestore/cloud_firestore.dart';

enum ComplaintStatus {
  pending,
  inProgress,
  resolved,
  rejected,
}

ComplaintStatus _complaintStatusFromMap(dynamic raw) {
  if (raw == null) return ComplaintStatus.pending;
  if (raw is String) {
    return ComplaintStatus.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => ComplaintStatus.pending,
    );
  }
  final idx = raw is int ? raw : int.tryParse(raw.toString());
  if (idx != null && idx >= 0 && idx < ComplaintStatus.values.length) {
    return ComplaintStatus.values[idx];
  }
  return ComplaintStatus.pending;
}

class ComplaintModel {
  final String id;
  final String complaint;
  final List<String> images;
  final String complaintBy;
  final String residentAdminID;
  final String societyID;
  final ComplaintStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ComplaintModel({
    required this.id,
    required this.complaint,
    required this.images,
    required this.complaintBy,
    required this.residentAdminID,
    required this.societyID,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String _statusToString(ComplaintStatus status) {
    return status.name;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "complaint": complaint,
      "images": images,
      "complaintBy": complaintBy,
      "residentAdminID": residentAdminID,
      "societyID": societyID,
      "status": _statusToString(status),
      "createdAt": Timestamp.fromDate(createdAt),
      "updatedAt": Timestamp.fromDate(updatedAt),
    };
  }

  factory ComplaintModel.fromMap(Map<String, dynamic> map) {
    return ComplaintModel(
      id: map["id"] ?? '',
      complaint: map["complaint"] ?? '',
      images: List<String>.from(map["images"] ?? []),
      complaintBy: map["complaintBy"] ?? '',
      residentAdminID: map["residentAdminID"] ?? '',
      societyID: map["societyID"] ?? '',
      status: _complaintStatusFromMap(map["status"]),
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      updatedAt: (map["updatedAt"] as Timestamp).toDate(),
    );
  }

  ComplaintModel copyWith({
    String? id,
    String? complaint,
    List<String>? images,
    String? complaintBy,
    String? residentAdminID,
    String? societyID,
    ComplaintStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      complaint: complaint ?? this.complaint,
      images: images ?? this.images,
      complaintBy: complaintBy ?? this.complaintBy,
      residentAdminID: residentAdminID ?? this.residentAdminID,
      societyID: societyID ?? this.societyID,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}