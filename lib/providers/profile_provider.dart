import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/models/user_api_response_model.dart';
import 'package:portalixmx_app/res/api_constants.dart';
import 'package:portalixmx_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier{
  final _apiService = ApiService();
  bool _loadingProfile = false;
  bool _updatingProfile = false;

  UserModel? _user;

  bool get loadingProfile => _loadingProfile;
  bool get updatingProfile => _updatingProfile;
  UserModel? get user => _user;

  ProfileProvider(){
    _initProfile();
  }

  _initProfile()async{
    _loadingProfile = true;
    notifyListeners();
    final response = await _apiService.getRequest(endpoint: ApiConstants.userProfile, );

    if(response != null){
      if(response.statusCode == 200){
        UserApiResponse userApiResponse = UserApiResponse.fromJson(jsonDecode(response.body));
        _user = userApiResponse.data;
      }
      _loadingProfile = false;
      notifyListeners();
    }
  }

  Future<bool> updateUserProfile({required Map<String, dynamic> data})async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    bool result = false;
    if(token != null){
      _updatingProfile = true;
      notifyListeners();
      final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.updateProfile, data: data,);

      if(response != null){
        result = response.statusCode == 200;
        _initProfile();
      }
      _updatingProfile = false;
      notifyListeners();
    }

    return result;
  }


}