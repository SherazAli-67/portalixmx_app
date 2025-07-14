import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_app/models/complaints_api_response.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/services/api_service.dart';
import '../models/visitor_api_response.dart';
import '../res/api_constants.dart';

class MaintenanceProvider extends ChangeNotifier {
  bool addingComplaint =  false;
  final _apiService = ApiService();
  List<Complaint> _allComplaints  = [];

  List<Complaint> get allComplaints => _allComplaints;

  Future<bool> addComplaint({required String token, required String complaint, required List<File> files}) async{
    bool result = false;
    addingComplaint = true;
    notifyListeners();
    try{

      result = await _apiService.uploadComplaintWithImages(token: token, complaintText: complaint, images: files);
      addingComplaint = false;
      notifyListeners();
    }catch(e){
      addingComplaint = false;
      notifyListeners();
      debugPrint("Error while logging in: ${e.toString()}");
    }
    return result;
  }

  Future<Map<String, dynamic>?> getAllComplaints() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allComplaints,);
      if(response != null){
        ComplaintsResponse apiResponse = ComplaintsResponse.fromJson(jsonDecode(response.body));
        _allComplaints = apiResponse.data;
        _allComplaints.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
        notifyListeners();
      }


    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<bool> deleteComplaintByID(String complaintID) async {

    bool result = false;
    debugPrint("Delete Api called");
    try {
      String endPoint = '${ApiConstants.deleteComplaint}/$complaintID';


      final response = await _apiService.getRequest(endpoint: endPoint,);
      if(response != null){
        debugPrint("Delete complaint api response: ${response.body}");
        if (response.statusCode == 200) {
          result = true;
          Fluttertoast.showToast(msg: "Complaint is removed successfully");
          getAllComplaints();
        }
      }

    } catch (e) {
      print('Error occurred: $e');
    }
    return result;
  }
}