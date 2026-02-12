import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';
import '../../core/models/user_model.dart';

class UserService {
  static final UserService instance =  UserService._();
  UserService._();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getCurrentUser() async {
    try{
      String currentUID = _auth.currentUser!.uid;
     final docSnap = await _firestore.collection(FirebaseConst.residentsCollection).doc(currentUID).get();
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
       await _firestore.collection(FirebaseConst.residentsCollection).doc(currentUID).set(user.toMap());
       return null;
    } catch (e) {
      throw 'Failed to get user: $e';
    }
  }
}