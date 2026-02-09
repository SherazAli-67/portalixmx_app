import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationProvider extends ChangeNotifier{
  XFile? pickedImage;

  void onPickImageTap()async{
    ImagePicker imagPicked = ImagePicker();
    pickedImage = await imagPicked.pickImage(source: .gallery);
    if(pickedImage != null){
      notifyListeners();
    }
  }

  void onCreateAccountTap({required String name, required String email, required String password}){

  }
}