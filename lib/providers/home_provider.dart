import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/services/api_service.dart';
import '../models/visitor_api_response.dart';
import '../res/api_constants.dart';

class HomeProvider extends ChangeNotifier {
  bool addingGuestVisitor =  false;
  final _apiService = ApiService();
  List<Visitor> _visitors  = [];
  List<Guest> _guests  = [];

  List<Visitor> get visitors => _visitors;
  List<Guest> get guests => _guests;


  Future<Map<String, dynamic>?> getAllVisitors({required String token}) async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allVisitorsEndPoint, token: token);
      VisitorResponse apiResponse = VisitorResponse.fromJson(jsonDecode(response.body));
      _visitors = apiResponse.data;
      notifyListeners();
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<Map<String, dynamic>?> getAllGuests({required String token}) async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allGuestsEndPoint, token: token);
      GuestResponse apiResponse = GuestResponse.fromJson(jsonDecode(response.body));
      _guests = apiResponse.data;
      notifyListeners();
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<bool> addGuest({required String token, required Map<String, dynamic> data}) async{
    bool result = false;
    addingGuestVisitor = true;
    notifyListeners();
    try{
       final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.addGuest, token: token, data: data);
       if(response.statusCode == 200){
         result = true;
       }
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }
    addingGuestVisitor = false;
    notifyListeners();
    return result;
  }

  Future<void> addVisitor({required String token, required Map<String, dynamic> data}) async{
    addingGuestVisitor = true;
    notifyListeners();
    try{
       await _apiService.postRequestWithToken(endpoint: ApiConstants.addVisitor, token: token, data: {});

    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }
    addingGuestVisitor = false;
    notifyListeners();
  }
}