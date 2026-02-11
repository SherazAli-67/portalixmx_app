import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_app/services/api_service.dart';
import '../core/models/user_api_response_model.dart';
import '../core/res/api_constants.dart';
import '../core/res/app_constants.dart';

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

  Future<bool> updateUserProfile({required Map<String, dynamic> data, Function(UserModel)? onProfileUpdated})async {

    bool result = false;
    _updatingProfile = true;
    notifyListeners();
    try{
      result = await _apiService.updateProfile(map: data);
      final response = await _apiService.getRequest(endpoint: ApiConstants.userProfile);
      if(response != null){
        UserApiResponse userApiResponse = UserApiResponse.fromJson(jsonDecode(response.body));
        _user = userApiResponse.data;
        notifyListeners();
        if(onProfileUpdated != null){
          onProfileUpdated(_user!);
        }
      }
      // final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.updateProfile, data: data,);
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }else if(e is SocketException){
        errorMessage = AppConstants.noInternetMsg;
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint("Error while updating profile: $errorMessage");
    }

    _updatingProfile = false;
    notifyListeners();
    return result;
  }

 /* Future<bool> updateUserProfile({required Map<String, dynamic> data})async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    bool result = false;
    if(token != null){
      _updatingProfile = true;
      notifyListeners();
      final response = await _apiService.updateProfile(map: data);
      // final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.updateProfile, data: data,);
      if(response){

        debugPrint("Update api response: ${response.body}");
        result = response.statusCode == 200 || jsonDecode(response.body)['success'];
        if(result){
          _initProfile();
        }
      }
      _updatingProfile = false;
      notifyListeners();
    }

    return result;
  }*/


}