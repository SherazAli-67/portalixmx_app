import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/access_request_model.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';

import '../../core/models/access_model.dart';

class AccessRequestService {
  static final AccessRequestService _instance = AccessRequestService._internal();
  factory AccessRequestService() => _instance;
  AccessRequestService._internal();
  static AccessRequestService get instance => _instance;

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _getAccessRequestsCollection =>
      _firestore.collection(FirebaseConst.accessRequestsCol);

  Future<AccessRequestModel> createRequest({required DateTime date, required TimeOfDay time, required AccessModel access, required SocietyModel society, }) async {
    try {
      DateTime now = DateTime.now().toUtc();
      AccessRequestModel accessRequestModel = AccessRequestModel(
          id: now.toIso8601String(),
          requestByUID: _auth.currentUser!.uid,
          requestedAccessTitle: access.name,
          requestedAccessImage: access.image,
          residentAdminID: society.residentAdmin!,
          societyID: society.id,
          requestedForDate: date,
          requestedForTime: time,
          createdAt: now,
          updatedAt: now,
          status: AccessRequestStatus.pending);
      await _getAccessRequestsCollection.doc(accessRequestModel.id).set(accessRequestModel.toMap());
      return accessRequestModel;
    } catch (e) {
      throw Exception('Failed to add access request');
    }
  }

  Future<List<AccessRequestModel>> getAllRequests() async {
    try {
      final snapshot = await _getAccessRequestsCollection.where('requestByUID', isEqualTo: _auth.currentUser!.uid).get();
      return snapshot.docs
          .map((doc) => AccessRequestModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get requests');
    }
  }

  Stream<List<AccessRequestModel>> watchAllRequests() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return Stream.value([]);
    return _getAccessRequestsCollection
        .where('requestByUID', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AccessRequestModel.fromMap(doc.data()! as Map<String, dynamic>))
            .toList());
  }

  Future<List<AccessModel>> fetchAllAccess({required String societyID}) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConst.accessCol)
          .where('societyID', isEqualTo: societyID)
          .get();
      return snapshot.docs
          .map((doc) => AccessModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint("Failed to load access: ${e.toString()}");
    }
    return [];
  }
}
