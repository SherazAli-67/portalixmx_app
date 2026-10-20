import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/services/auth_service/auth_service.dart';
import 'package:portalixmx_app/services/push_notification_service/push_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier{
  XFile? pickedImage;
  final _authService = AuthService.instance;

  bool _isSigningUp = false;
  bool _isSigningIn = false;

  bool _isCompletingProfile = false;

  bool get isSigningUp => _isSigningUp;
  bool get isSigningIn => _isSigningIn;
  bool get isCompletingProfile => _isCompletingProfile;
  SocietyModel? selectedSociety;

  bool loadingSocieties = false;
  String? societiesError;

  List<SocietyModel> societies = [];
  AuthenticationProvider(){
    loadSocieties();
  }

  void clearUserState() {
    pickedImage = null;
    selectedSociety = null;
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await PushNotificationService.instance.removeTokenForSignOut();
    clearUserState();
    await FirebaseAuth.instance.signOut();
  }
  void onPickImageTap()async{
    ImagePicker imagPicked = ImagePicker();
    pickedImage = await imagPicked.pickImage(source: .gallery);
    if(pickedImage != null){
      notifyListeners();
    }
  }

  Future<String?> onCreateAccountTap({required String email, required String name, required String password})async{
    _isSigningUp = true;
    notifyListeners();
    try{
      if(pickedImage == null) return 'please_upload_profile_picture';
      await _authService.signup(name: name, email: email, password: password,
          societyID: selectedSociety!.id, image: pickedImage!);
      return null;
    }catch(e){
      return e.toString();
    }finally{
      _isSigningUp = false;
      notifyListeners();
    }
  }

  Future<String?> onCompleteProfileTap({
    required String phoneNum,
    required String vehicleName,
    required String vehicleColor,
    required String licensePlateNum,
    required String registrationNum,
    required String emergencyContact}) async {
    _isCompletingProfile = true;
    notifyListeners();
    try{
      UserModel? user = await _authService.getCurrentUser();
      if(user == null) return 'user_not_found';
      VehicleInformation vehicleInformation = VehicleInformation(name: vehicleName, color: vehicleColor, registrationNumber: registrationNum, licensePlateNumber: licensePlateNum);
      final updatedUser = user.copyWith(vehicleInformation: vehicleInformation, emergencyContacts: [emergencyContact], phoneNum: phoneNum);
      return await _authService.updateUser(user: updatedUser);
    }catch(e){
      return e.toString();
    }finally{
      _isCompletingProfile = false;
      notifyListeners();
    }
  }

  Future<String?> onSignInTap({required String email, required String password}) async {
    _isSigningIn = true;
    notifyListeners();
    try{
      await _authService.signIn(email: email, password: password);
      return null;
    }catch(e){
      return e.toString();
    }finally{
      _isSigningIn = false;
      notifyListeners();
    }
  }

  void loadSocieties() async{
    try{
      loadingSocieties = true;
      societiesError = null;
      notifyListeners();
      societies = await _authService.getSocieties();
      if (societies.isEmpty) {
        societiesError = 'failed_to_load_societies';
      }
    }catch(e){
      societies = [];
      societiesError = e.toString();
      debugPrint("Exception while initializing societies:${e.toString()}");
    }finally{
      loadingSocieties = false;
      notifyListeners();
    }
  }
  void onSelectSocietyTap(SocietyModel society){
    selectedSociety = society;
    notifyListeners();
  }

  Future<UserModel?> refreshCurrentUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (_) {
      return null;
    }
  }
}