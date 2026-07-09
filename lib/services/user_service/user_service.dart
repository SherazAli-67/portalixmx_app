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
}