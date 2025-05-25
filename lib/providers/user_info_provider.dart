import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/visitor_api_response.dart';
import '../res/api_constants.dart';

class UserViewModel extends ChangeNotifier {
  final _apiService = ApiService();
  final String _tokenKey = 'token';
  final String _userIDKey = 'userID';
  final String _userNameKey = 'userName';
  final String _userEmailKey = 'emailAddress';
  List<Visitor> _visitors  = [];
  List<Guest> _guests  = [];
  String? _token;
  String? _userID;
  String? _userName;
  String? _emailAddress;

  String? get token => _token;
  String? get userID => _userID;
  String? get userName => _userName;
  String? get emailAddress => _emailAddress;
  List<Visitor> get visitors => _visitors;
  List<Guest> get guests => _guests;


  UserViewModel(){
    _initUserInfo();
  }

  void setUserInfo({required String token, required String name, required String userID, required String email})async{
    _token = token;
    _userName = name;
    _userID = userID;
    _emailAddress = email;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_tokenKey, token);
    sharedPreferences.setString(_userIDKey, userID);
    sharedPreferences.setString(_userNameKey, name);
    sharedPreferences.setString(_userEmailKey, email);

  }

  void _initUserInfo()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _token = sharedPreferences.getString(_tokenKey);
    _userID = sharedPreferences.getString(_userIDKey);
    _emailAddress = sharedPreferences.getString(_userEmailKey);
    _userName = sharedPreferences.getString(_userNameKey);

    notifyListeners();
  }


  Future<Map<String, dynamic>?> getAllVisitors() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allVisitorsEndPoint, token: token!);
      VisitorResponse apiResponse = VisitorResponse.fromJson(jsonDecode(response.body));
      _visitors = apiResponse.data;
      notifyListeners();
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }

  Future<Map<String, dynamic>?> getAllGuests() async{

    try{
      final response =  await _apiService.getRequest(endpoint: ApiConstants.allGuestsEndPoint, token: token!);
      GuestResponse apiResponse = GuestResponse.fromJson(jsonDecode(response.body));
      _guests = apiResponse.data;
      notifyListeners();
    }catch(e){
      debugPrint("Error while logging in: ${e.toString()}");
    }

    return null;
  }
}