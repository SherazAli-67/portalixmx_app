import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/models/visitor_api_response.dart';
import 'package:portalixmx_app/res/api_constants.dart';

import '../services/api_service.dart';

class HomeRepository {
  final ApiService _apiService = ApiService();


  Future<Map<String, dynamic>?> getAllGuests({required String token}) async{

    try{
     final response =  await _apiService.getRequest(endpoint: ApiConstants.allVisitorsEndPoint, token: token);

    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<Map<String, dynamic>?> getAllVisitors({required String token}) async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allVisitorsEndPoint, token: token);
      VisitorResponse apiResponse = VisitorResponse.fromJson(jsonDecode(response.body));

    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }
}