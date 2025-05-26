import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  final String _tokenKey = 'token';
  final String _userIDKey = 'userID';
  final String _userNameKey = 'userName';
  final String _userEmailKey = 'emailAddress';
  String? _token;
  String? _userID;
  String? _userName;
  String? _emailAddress;

  String? get token => _token;
  String? get userID => _userID;
  String? get userName => _userName;
  String? get emailAddress => _emailAddress;


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
    _token = sharedPreferences.getString(_tokenKey) ?? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW4iLCJ1c2VySWQiOiI2ODJjYzI0MWVjNDNiZTMyYTQ5MmYxNDQiLCJyZW1lbWJlckZsYWciOmZhbHNlLCJpYXQiOjE3NDgxNjcwMzAsImV4cCI6MTc0ODI1MzQzMH0.AhVTpIu3ISqWufNLQ9OH4DyLSuY0l6KAn8aGzEIEQSE';
    _userID = sharedPreferences.getString(_userIDKey) ?? '682cc241ec43be32a492f144';
    _emailAddress = sharedPreferences.getString(_userEmailKey) ?? 'admin.portalix@gmail.com';
    _userName = sharedPreferences.getString(_userNameKey) ?? 'Portalix ADMIN';

    notifyListeners();
  }

}