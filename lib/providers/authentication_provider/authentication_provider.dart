import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/services/auth_service/auth_service.dart';

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

  List<SocietyModel> societies = [];
  bool loadingSocieties = false;
  AuthenticationProvider(){
    _initSocieties();
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
      if(pickedImage == null) return 'Please upload your profile picture';
      await _authService.signup(name: name, email: email, password: password,
          societyID: selectedSociety!.id, profilePicture: pickedImage!);
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
      if(user == null) return 'User not found!';
      VehicleInformation vehicleInformation = VehicleInformation(name: vehicleName, color: vehicleColor, registrationNumber: registrationNum, licensePlateNumber: licensePlateNum);
      final updatedUser = user.copyWith(vehicleInformation: vehicleInformation, emergencyContacts: [emergencyContact]);
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

  void _initSocieties() async{
    try{
      loadingSocieties = true;
      notifyListeners();
      societies = await _authService.getSocieties();
      debugPrint("Societies: ${societies.length}");
      loadingSocieties = false;
      notifyListeners();
    }catch(e){
      loadingSocieties = false;
      notifyListeners();
      debugPrint("Exception while initializing societies:${e.toString()}");
    }
  }
  void onSelectSocietyTap(SocietyModel society){
    selectedSociety = society;
    notifyListeners();
  }
}