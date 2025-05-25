import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/res/api_constants.dart';

import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();


  Future<void> loginUser({required String email, required String password}) async{
    final data = {
      'username' : email,
      'password' : password
    };
    try{
      await _apiService.postRequest(endpoint: ApiConstants.loginEndPoint, data: data);
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

  }

  Future<void> verifyOTP({required String otp, required String token}) async{
    final data = {
      'otp' : otp,
    };
    try{
      await _apiService.postRequestWithToken(endpoint: ApiConstants.loginEndPoint, data: data, token: token);
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

  }
}