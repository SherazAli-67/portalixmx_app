import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityEventModel {
  final String id;
  final String eventTitle;
  final String eventDescription;
  final DateTime eventDate;
  final TimeOfDay eventTime;
  final DateTime createdAt;
  final String? imageUrl;

  CommunityEventModel({
    required this.id,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventTime,
    required this.createdAt,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventDate': eventDate.millisecondsSinceEpoch,
      'eventTime': {
        'hour': eventTime.hour,
        'minute': eventTime.minute,
      },
      'createdAt': createdAt.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }

  static DateTime _parseDate(dynamic raw) {
    if (raw is Timestamp) return raw.toDate();
    if (raw is int) return DateTime.fromMillisecondsSinceEpoch(raw);
    if (raw is num) return DateTime.fromMillisecondsSinceEpoch(raw.toInt());
    if (raw is String) {
      final asInt = int.tryParse(raw);
      if (asInt != null) return DateTime.fromMillisecondsSinceEpoch(asInt);
      return DateTime.parse(raw);
    }
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  factory CommunityEventModel.fromMap(Map<String, dynamic> map) {
    final eventTimeMap = map['eventTime'];
    return CommunityEventModel(
      id: map['id'] ?? '',
      eventTitle: map['eventTitle'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventDate: _parseDate(map['eventDate']),
      eventTime: TimeOfDay(
        hour: eventTimeMap is Map ? (eventTimeMap['hour'] as int? ?? 0) : 0,
        minute: eventTimeMap is Map ? (eventTimeMap['minute'] as int? ?? 0) : 0,
      ),
      createdAt: _parseDate(map['createdAt']),
      imageUrl: map['imageUrl'] as String?,
    );
  }

  CommunityEventModel copyWith({
    String? id,
    String? eventTitle,
    String? eventDescription,
    DateTime? eventDate,
    TimeOfDay? eventTime,
    DateTime? createdAt,
    String? imageUrl,
  }) {
    return CommunityEventModel(
      id: id ?? this.id,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
      eventTime: eventTime ?? this.eventTime,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
