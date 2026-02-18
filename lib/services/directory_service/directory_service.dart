import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';

class DirectoryService {
  static final DirectoryService _instance = DirectoryService._internal();
  factory DirectoryService() => _instance;
  DirectoryService._internal();

  static DirectoryService get instance => _instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference _getDirectoryCollection(String userID) {
    return _firestore
        .collection(FirebaseConst.residentsCol)
        .doc(userID)
        .collection(FirebaseConst.guestsDirectoryCol);
  }

  Future<void> updateVisitor(String userID, String visitorID, BaseVisitor visitor) async {
    try {
      await _getDirectoryCollection(userID)
          .doc(visitorID)
          .update(visitor.toFirestore());
    } catch (e) {
      throw Exception('Failed to update visitor: $e');
    }
  }

  Future<void> deleteVisitor(String userID, String visitorID) async {
    try {
      await _getDirectoryCollection(userID).doc(visitorID).delete();
    } catch (e) {
      throw Exception('Failed to delete visitor: $e');
    }
  }

  Future<List<BaseVisitor>> getVisitors(String userID) async {
    try {
      final snapshot = await _getDirectoryCollection(userID).get();
      return snapshot.docs
          .map((doc) => BaseVisitor.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get visitors: $e');
    }
  }

  Future<List<BaseVisitor>> initDirectoryGuests(String userID) async {
    try {
      final snapshot = await _getDirectoryCollection(userID).get();
      return snapshot.docs
          .map((doc) => BaseVisitor.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get visitors: $e');
    }
  }
}
