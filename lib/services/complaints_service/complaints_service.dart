import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/models/complaints_model.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/res/firebase_constant.dart';

class ComplaintsService {
  static final ComplaintsService _instance = ComplaintsService._internal();
  factory ComplaintsService() => _instance;
  ComplaintsService._internal();
  static ComplaintsService get instance => _instance;

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _getComplaintsCollection => _firestore.collection(FirebaseConst.complaintsCol);

  Future<ComplaintModel?> addComplaint({required String complaintText, List<String>? images, required SocietyModel society}) async {
    try {
      DateTime now = DateTime.now().toUtc();
      ComplaintModel complaint = ComplaintModel(id: now.toIso8601String(),
          complaint: complaintText,
          images: images ?? [],
          complaintBy: _auth.currentUser!.uid,
          residentAdminID: society.residentAdmin!,
          societyID: society.id,
          status: ComplaintStatus.pending,
          createdAt: now,
          updatedAt: now);
      print("ComplaintS: ${complaint.toMap()}");
      await _getComplaintsCollection.doc(complaint.id).set(complaint.toMap());
      return complaint;
    } catch (e) {
      throw Exception('Failed to create complaint request: $e');
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

  Future<void> deleteComplaintByID(String complaintID) async{
    try {
      await _getComplaintsCollection.doc(complaintID).delete();
    } catch (e) {
      throw Exception('Failed to delete complaint: $e');
    }
  }

  Future<List<String>> uploadComplaintImages({required List<XFile> files}) async {
    debugPrint("Uploading complaint image: ${files.length}");
    try{
      String currentUID = FirebaseAuth.instance.currentUser!.uid;
      List<String> imagesUrl = [];
      for (var file in files) {
        String path = file.path.split('/').last;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child("complaints_by_residents/$currentUID/$path");
        TaskSnapshot task = await storageRef.putFile(File(file.path));
        String imageUrl = await task.ref.getDownloadURL();
        imagesUrl.add(imageUrl);
      }
      return imagesUrl;
    }catch(e){
      throw Exception("Failed to upload image: ${e.toString()}");
    }
  }
}
