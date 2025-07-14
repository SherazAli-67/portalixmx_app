import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portalixmx_app/models/access_control_api_response.dart';
import 'package:portalixmx_app/services/api_service.dart';
import '../res/api_constants.dart';

class RequestAccessProvider extends ChangeNotifier {
  bool addingRequestAccess =  false;
  final _apiService = ApiService();
  List<AccessModel> _allAccessRequests  = [];

  List<AccessModel> get allAccessRequests => _allAccessRequests;

  Future<bool> addRequestAccessControl({required String id,}) async{
    bool result = false;
    addingRequestAccess = true;
    notifyListeners();
    try{

      final data = {
        "id": id,
        "requestTime": '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}',
        "requestDate": DateTime.now().toIso8601String()
      };
      final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.saveAccessControl, data: data, );
      if(response != null){
        result = response.statusCode == 200;
        addingRequestAccess = false;
        notifyListeners();
      }
    }catch(e){
      addingRequestAccess = false;
      notifyListeners();
      debugPrint("Error while logging in: ${e.toString()}");
    }
    return result;
  }

  Future<Map<String, dynamic>?> getAllRequestControlList() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.userAccessControlList,);
      if(response != null){
        debugPrint("Body: ${response.body}");

        AccessControlApiResponse apiResponse = AccessControlApiResponse.fromJson(jsonDecode(response.body));
        _allAccessRequests = apiResponse.data;
        _allAccessRequests.sort((a, b)=> b.access.first.timeStamp.compareTo(a.access.first.timeStamp));
        notifyListeners();
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }
}