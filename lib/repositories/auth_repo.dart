import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/res/api_constants.dart';

import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();


  Future<Map<String, dynamic>?> loginUser({required String email, required String password}) async{
    final data = {
      'username' : email,
      'password' : password
    };
    try{
     final response =  await _apiService.postRequest(endpoint: ApiConstants.loginEndPoint, data: data);
     final Map<String,dynamic> map = jsonDecode(response.body)['data']['token']!;
     return map;
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<void> verifyOTP({required String otp, required String token}) async{
    final data = {
      'otp' : otp,
    };
    try{
      await _apiService.postRequestWithToken(endpoint: ApiConstants.verifyOTPEndPoint, data: data, token: token);
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

  }
}