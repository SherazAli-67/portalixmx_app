import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/services/api_service.dart';
import '../models/visitor_api_response.dart';
import '../res/api_constants.dart';

class MaintenanceProvider extends ChangeNotifier {
  bool addingComplaint =  false;
  final _apiService = ApiService();


  Future<bool> addComplaint({required String token, required String complaint, required List<File> files}) async{
    bool result = false;
    addingComplaint = true;
    notifyListeners();
    try{
      final response = _apiService.postComplaintWithImages(
          endpoint: ApiConstants.addComplaint,
          token: token,
          complaintText: complaint,
          images: files);

      return response;
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }
    addingComplaint = false;
    notifyListeners();
    return result;
  }

}