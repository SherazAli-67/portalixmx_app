import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:portalixmx_app/core/models/payment_submitted_model.dart';
import '../../core/models/payment_model.dart';
import '../../core/res/firebase_constant.dart';

class PaymentsService {
  static final PaymentsService _instance = PaymentsService._internal();
  factory PaymentsService() => _instance;
  PaymentsService._internal();
  static PaymentsService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getCountBySociety(String societyID) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConst.paymentsCol)
          .where('societyID', isEqualTo: societyID)
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<List<PaymentModel>> getPayments(String societyID) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConst.paymentsCol)
          .where('societyID', isEqualTo: societyID)
          .get();
      return snapshot.docs.map((doc)=> PaymentModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<List<PaymentModel>> getUserPaymentHistory({required String userID}) async {
    try {
      final snapshot = await _firestore
          .collection(FirebaseConst.paymentsCol)
          .where('paymentByUID', isEqualTo: userID)
          .get();
      return snapshot.docs.map((doc)=> PaymentModel.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }



  Future<void> submitPaymentToAdmin({required String paymentID, required PaymentSubmittedModel paymentSubmitted}) async {
    try{
      await _firestore
          .collection(FirebaseConst.paymentsCol)
          .doc(paymentID)
          .collection(
          FirebaseConst.paymentsSubmittedCol)
          .doc(paymentSubmitted.paymentByUID)
          .set(paymentSubmitted.toMap());
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<PaymentStatus> getPaymentStatus({required String paymentID,}) async {
    try{
      User? authUser = FirebaseAuth.instance.currentUser;
      if(authUser == null) throw Exception("User not found");
     DocumentSnapshot docSnap =  await _firestore
          .collection(FirebaseConst.paymentsCol)
          .doc(paymentID)
          .collection(
          FirebaseConst.paymentsSubmittedCol)
          .doc(authUser.uid).get();
      if(docSnap.exists){
        Map<String, dynamic> map = docSnap.data() as Map<String, dynamic>;
        return map['approvedOnDate'] != null ? PaymentStatus.received : PaymentStatus.submitted;
      }
      return PaymentStatus.pending;
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<String> uploadPaymentReceipt({required String receipt}) async {
    try{
      String currentUID = FirebaseAuth.instance.currentUser!.uid;
      String path = receipt.split('/').last;
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("payments_by_residents/$currentUID/$path");
      TaskSnapshot task = await storageRef.putFile(File(receipt));
      String imageUrl = await task.ref.getDownloadURL();
      return imageUrl;
    }catch(e){
      throw Exception("Failed to upload image: ${e.toString()}");
    }
  }

  Future<void> updatePayment({required PaymentModel payment}) async {
    try{
      User? authUser = FirebaseAuth.instance.currentUser;
      if(authUser == null) throw Exception("User not found");
      await _firestore
          .collection(FirebaseConst.paymentsCol)
          .doc(payment.paymentID).set(payment.toMap());
    }catch(e){
      throw Exception(e.toString());
    }
  }
}
