import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoProvider extends ChangeNotifier {
  final String _userIDKey = 'userID';
  final String _userNameKey = 'userName';
  final String _userEmailKey = 'emailAddress';


  String? _userID;
  String? _userName;
  String? _emailAddress;

  String? get userID => _userID;
  String? get userName => _userName;
  String? get emailAddress => _emailAddress;

  UserInfoProvider(){
    _initUserInfo();
  }

  void setUserInfo({required String name, required String userID, required String email})async{
    _userName = name;
    _userID = userID;
    _emailAddress = email;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_userIDKey, userID);
    sharedPreferences.setString(_userNameKey, name);
    sharedPreferences.setString(_userEmailKey, email);
  }

  void _initUserInfo()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _userID = sharedPreferences.getString(_userIDKey);
    _emailAddress = sharedPreferences.getString(_userEmailKey);
    _userName = sharedPreferences.getString(_userNameKey);

    notifyListeners();
  }
}