import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portalixmx_app/core/models/complaints_api_response.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';

class ComplaintsService {
  static final ComplaintsService _instance = ComplaintsService._internal();
  factory ComplaintsService() => _instance;
  ComplaintsService._internal();
  static ComplaintsService get instance => _instance;

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _getComplaintsCollection => _firestore.collection(FirebaseConst.complaints);

  Future<ComplaintModel?> addComplaint({required String complaintText, List<String>? images}) async {
    try {
      DateTime now = DateTime.now().toUtc();
      ComplaintModel complaint = ComplaintModel(id: now.toIso8601String(),
          complaint: complaintText,
          images: images ?? [],
          complaintBy: _auth.currentUser!.uid,
          residentAdminID: '1',
          societyID: '1',
          status: ComplaintStatus.pending,
          createdAt: now,
          updatedAt: now);
      await _getComplaintsCollection.doc(complaint.id).set(complaint.toMap());
      return complaint;
    } catch (e) {
      throw Exception('Failed to add visitor: $e');
    }
  }

  Future<List<ComplaintModel>> getAllComplaints() async {
    try {
      final snapshot = await _getComplaintsCollection.where('complaintBy', isEqualTo: _auth.currentUser!.uid).get();
      return snapshot.docs
          .map((doc) => ComplaintModel.fromMap(doc.data()! as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get visitors: $e');
    }
  }
}
