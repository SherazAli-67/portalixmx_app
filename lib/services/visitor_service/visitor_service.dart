import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';

class VisitorService {
  static final VisitorService _instance = VisitorService._internal();
  factory VisitorService() => _instance;
  VisitorService._internal();

  static VisitorService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getVisitorsCollection(String userID) {
    return _firestore
        .collection(FirebaseConst.residentsCollection)
        .doc(userID)
        .collection(FirebaseConst.visitorsCollection);
  }

  Future<String> addVisitor(String userID, BaseVisitor visitor) async {
    try {
      final docRef = await _getVisitorsCollection(userID).add(visitor.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add visitor: $e');
    }
  }

  Future<void> updateVisitor(String userID, String visitorID, BaseVisitor visitor) async {
    try {
      await _getVisitorsCollection(userID)
          .doc(visitorID)
          .update(visitor.toFirestore());
    } catch (e) {
      throw Exception('Failed to update visitor: $e');
    }
  }

  Future<void> deleteVisitor(String userID, String visitorID) async {
    try {
      await _getVisitorsCollection(userID).doc(visitorID).delete();
    } catch (e) {
      throw Exception('Failed to delete visitor: $e');
    }
  }

  Future<List<BaseVisitor>> getVisitors(String userID) async {
    try {
      final snapshot = await _getVisitorsCollection(userID).get();
      return snapshot.docs
          .map((doc) => BaseVisitor.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get visitors: $e');
    }
  }

  Future<List<BaseVisitor>> getVisitorsByType(String userID, String visitorType) async {
    try {
      final snapshot = await _getVisitorsCollection(userID)
          .where('visitorType', isEqualTo: visitorType)
          .get();
      return snapshot.docs
          .map((doc) => BaseVisitor.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get visitors by type: $e');
    }
  }

  Future<BaseVisitor?> getVisitor(String userID, String visitorID) async {
    try {
      final doc = await _getVisitorsCollection(userID).doc(visitorID).get();
      if (doc.exists) {
        return BaseVisitor.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get visitor: $e');
    }
  }

  Stream<List<BaseVisitor>> getVisitorsStream(String userID) {
    return _getVisitorsCollection(userID).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => BaseVisitor.fromFirestore(doc))
              .toList(),
        );
  }

  Stream<List<BaseVisitor>> getVisitorsByTypeStream(String userID, String visitorType) {
    return _getVisitorsCollection(userID)
        .where('visitorType', isEqualTo: visitorType)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BaseVisitor.fromFirestore(doc))
              .toList(),
        );
  }
}
