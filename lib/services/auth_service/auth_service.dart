import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';
import 'package:portalixmx_app/firebase_options.dart';

import '../../core/models/user_model.dart';

class AuthService {
  static final AuthService instance =  AuthService._();
  AuthService._();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _functions = FirebaseFunctions.instanceFor(region: 'us-central1');

  FirebaseStorage get _storage {
    final bucket = DefaultFirebaseOptions.currentPlatform.storageBucket;
    return FirebaseStorage.instanceFor(
      app: Firebase.app(),
      bucket: 'gs://$bucket',
    );
  }

  Future<User?> signup({required String name, required String email, required String password, required String societyID, XFile? image}) async {
    try{
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var authUser = userCredential.user;
      if (authUser == null) return null;

      await authUser.reload();
      authUser = _auth.currentUser ?? authUser;
      await authUser.getIdToken(true);

      final user = UserModel(
        userID: authUser.uid,
        userName: name,
        email: email,
        createdAt: DateTime.now().toUtc(),
        societyID: societyID,
      );
      final userMap = user.toMap();
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          userMap['token'] = fcmToken;
        }
      } catch (_) {}
      await _firestore.collection(FirebaseConst.residentsCol).doc(user.userID).set(userMap);

      if (image != null) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        await _auth.currentUser!.getIdToken(true);
        final profilePicture = await updateProfilePicture(image);
        await _firestore.collection(FirebaseConst.residentsCol).doc(user.userID).set(
          {'profileImg': profilePicture},
          SetOptions(merge: true),
        );
      }

      return _auth.currentUser ?? authUser;
    }on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Failed to sign up: $e';
    }
  }

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password,);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Failed to sign in: $e';
    }
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    // Return Firebase error codes; localize at the UI layer via AuthErrorLocalizer.
    switch (e.code) {
      case 'invalid-email':
      case 'user-disabled':
      case 'user-not-found':
      case 'wrong-password':
      case 'email-already-in-use':
      case 'operation-not-allowed':
      case 'weak-password':
      case 'invalid-credential':
      case 'requires-recent-login':
        return e.code;
      default:
        return e.code.isNotEmpty ? e.code : 'unknown';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String?> deleteAccount() async {
    try{
      String currentUID = FirebaseAuth.instance.currentUser!.uid;
      await _firestore.collection(FirebaseConst.residentsCol).doc(currentUID).delete();

      await _auth.currentUser!.delete();
      return null;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        rethrow;
      }
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Failed to delete user: $e';
    }
  }

  Future<void> reauthenticateWithPassword(String password) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw 'No user is currently signed in';
      }

      final email = user.email;
      if (email == null) {
        throw 'User email is not available';
      }

      final credential = EmailAuthProvider.credential(email: email, password: password);
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw 'Failed to re-authenticate: $e';
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try{
      String currentUID = FirebaseAuth.instance.currentUser!.uid;

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
      String currentUID = FirebaseAuth.instance.currentUser!.uid;
       await _firestore.collection(FirebaseConst.residentsCol).doc(currentUID).set(user.toMap(), SetOptions(merge: true));
       return null;
    } catch (e) {
      throw 'Failed to get user: $e';
    }
  }

  Future<List<SocietyModel>> getSocieties() async {
    try {
      final callable = _functions.httpsCallable('listSocietiesForSignup');
      final result = await callable.call();
      final data = result.data;
      final rawList = data is Map ? data['societies'] : null;
      if (rawList is! List) {
        throw 'Failed to load societies';
      }
      final societies = rawList.map((item) {
        final map = Map<String, dynamic>.from(item as Map);
        return SocietyModel.fromMap(map);
      }).toList();
      if (societies.isEmpty) {
        throw 'Failed to load societies';
      }
      return societies;
    } on FirebaseFunctionsException catch (e) {
      throw e.message ?? 'Failed to load societies';
    } catch (e) {
      throw 'Failed to load societies: $e';
    }
  }

  Future<SocietyModel?> getSociety() async {
    try{
      UserModel? user = await getCurrentUser();
      if(user == null) throw Exception('User not found');
      DocumentSnapshot docSnap = await _firestore.collection(FirebaseConst.societiesCol).doc(user.societyID).get();
      return SocietyModel.fromMap(docSnap.data() as Map<String, dynamic>);
    } catch (e) {
      throw 'Failed to get society: $e';
    }
  }

  Future<String?> updateProfilePicture(XFile image) async {
    try{
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated');
      }
      final token = await user.getIdToken(true);
      if (token == null || token.isEmpty) {
        throw Exception('Auth token missing for Storage upload');
      }

      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final storageRef = _storage.ref().child('residents/profile_pictures/${user.uid}/$fileName');
      final bytes = await image.readAsBytes();
      debugPrint('Storage upload uid=${user.uid} path=${storageRef.fullPath} bytes=${bytes.length}');
      final task = await storageRef.putData(
        bytes,
        SettableMetadata(contentType: image.mimeType ?? 'image/jpeg'),
      );
      return await task.ref.getDownloadURL();
    }catch(e){
      debugPrint("Error while uploading image: ${e.toString()}");
      throw Exception("Failed to upload image: ${e.toString()}");
    }
  }
}