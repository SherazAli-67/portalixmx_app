import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/access_control_api_response.dart';
import 'package:portalixmx_app/models/access_control_model.dart';
import 'package:portalixmx_app/res/app_constants.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../res/api_constants.dart';

class RequestAccessProvider extends ChangeNotifier {
  bool addingRequestAccess =  false;
  final _allAccessKey = 'accessList';
  final _apiService = ApiService();
  List<AccessModel> _allAccessItems = [];
  List<AccessRequestModel> _allAccessRequests  = [];

  RequestAccessProvider(){
    _initAccessControlList();
  }

  List<AccessRequestModel> get allAccessRequests => _allAccessRequests;
  List<AccessModel> get allAccessItems => _allAccessItems;

  Future<bool> addRequestAccessControl({required Map<String, dynamic> data, required String accessTitle, required BuildContext context}) async{
    bool result = false;
    addingRequestAccess = true;
    notifyListeners();
    try{

      final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.saveAccessControl, data: data, );
      if(response != null){
        result = response.statusCode == 200 || jsonDecode(response.body)['status'];
        String message = jsonDecode(response.body)['data'];
        if(message == AppConstants.accessRequestPending){
          Fluttertoast.showToast(msg: AppLocalizations.of(context)!.accessRequestPending(accessTitle));
        }else{
          Fluttertoast.showToast(msg: AppLocalizations.of(context)!.accessRequestSubmitted(accessTitle));
          _loadAccessControlList();
        }
        Navigator.of(context).pop();
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
        // debugPrint("Body: ${response.body}");

        AccessRequestControlApiResponse apiResponse = AccessRequestControlApiResponse.fromJson(jsonDecode(response.body));
        _allAccessRequests = apiResponse.data;
        _allAccessRequests.sort((a, b)=> b.access.first.timeStamp.compareTo(a.access.first.timeStamp));
        notifyListeners();
      }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  void _initAccessControlList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessItems = prefs.getString(_allAccessKey);
    if(accessItems != null){
      List<dynamic> accessList = jsonDecode(accessItems);
      _allAccessItems = accessList.map((item)=> AccessModel.fromJson(item)).toList();
      notifyListeners();
    }else{
      _loadAccessControlList();
    }
  }

  void _loadAccessControlList() async{
    // bool result = false;
    final response = await  _apiService.getRequest(endpoint: ApiConstants.allAccessControlList);
    if(response != null){
      // result = response.statusCode == 200 && jsonDecode(response.body)['status'];
      final apiResponse = AccessControlApiResponse.fromJson(jsonDecode(response.body));
      _allAccessItems = apiResponse.data;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<dynamic> list = _allAccessItems.map((item)=> item.toJson()).toList();
      await prefs.setString(_allAccessKey, jsonEncode(list));
    }
  }

  String getImageByTitle(String title) {
    switch(title){
      case "Poll":
        return AppIcons.icPool;

      case "GYM":
        return AppIcons.icGym;

      default:
        return AppIcons.icGame;
    }
  }
}