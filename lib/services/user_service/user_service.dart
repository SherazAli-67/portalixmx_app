import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';
import '../../core/models/society_model.dart';
import '../../core/models/user_model.dart';

class UserService {
  static final UserService instance =  UserService._();
  UserService._();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUser() async {
    try{
      String currentUID = _auth.currentUser!.uid;
     final docSnap = await _firestore.collection(FirebaseConst.residentsCol).doc(currentUID).get();
     if(docSnap.exists){
       return UserModel.fromMap(docSnap.data()!);
     }
      return null;
    } catch (e) {
      throw 'Failed to get user: $e';
    }
  }

  Future<String?> updateUser({required UserModel user}) async{
    try{
      String currentUID = _auth.currentUser!.uid;
       await _firestore.collection(FirebaseConst.residentsCol).doc(currentUID).set(user.toMap());
       return null;
    } catch (e) {
      throw 'Failed to get user: $e';
    }
  }

  Future<SocietyModel?> getSocietyByID({required String societyID}) async {
    try{
      UserModel? user = await getCurrentUser();
      if(user == null) throw Exception('User not found');
      QuerySnapshot docSnap = await _firestore.collection(FirebaseConst.societiesCol).where('id', isEqualTo: societyID).get();
      if(docSnap.docs.isNotEmpty){
        return SocietyModel.fromMap(docSnap.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw 'Failed to get society: $e';
    }
  }

  Future<List<UserModel>> getSocietyResidents({required String societyID}) async {
    try {
      final currentUID = _auth.currentUser!.uid;
      final snapshot = await _firestore
          .collection(FirebaseConst.residentsCol)
          .where('societyID', isEqualTo: societyID)
          .get();
      final residents = <UserModel>[];
      for (final doc in snapshot.docs) {
        final user = _userFromDoc(doc);
        if (user == null) continue;
        if (user.userID == currentUID) continue;
        if (!user.isApproved) continue;
        residents.add(user);
      }
      residents.sort((a, b) => a.userName.toLowerCase().compareTo(b.userName.toLowerCase()));
      return residents;
    } catch (e) {
      throw 'Failed to get residents: $e';
    }
  }

  Future<List<UserModel>> getResidentsByIds(List<String> ids) async {
    if (ids.isEmpty) return [];
    try {
      final snaps = await Future.wait(
        ids.map((id) => _firestore.collection(FirebaseConst.residentsCol).doc(id).get()),
      );
      final users = <UserModel>[];
      for (final snap in snaps) {
        final user = _userFromDoc(snap);
        if (user == null) continue;
        users.add(user);
      }
      return users;
    } catch (e) {
      throw 'Failed to get residents: $e';
    }
  }

  Future<void> updateEmergencyContacts({required List<String> contactIds}) async {
    try {
      final currentUID = _auth.currentUser!.uid;
      await _firestore.collection(FirebaseConst.residentsCol).doc(currentUID).set(
        {'emergencyContacts': contactIds},
        SetOptions(merge: true),
      );
    } catch (e) {
      throw 'Failed to update emergency contacts: $e';
    }
  }

  UserModel? _userFromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) return null;
    try {
      final map = Map<String, dynamic>.from(data as Map);
      final createdAt = map['createdAt'];
      if (createdAt is Timestamp) {
        map['createdAt'] = createdAt.toDate().toUtc().toIso8601String();
      }
      final user = UserModel.fromMap(map);
      if (user.userID.isEmpty) {
        return user.copyWith(userID: doc.id);
      }
      return user;
    } catch (_) {
      return null;
    }
  }
}