import 'package:portalixmx_app/models/access_request_model.dart';
import 'package:portalixmx_app/models/emergency_contact_model.dart';
import 'package:portalixmx_app/res/app_icons.dart';

class AppData {
  static final List<String> days = [
    'MON', 'TUE','WED', 'THU', 'FRI','SAT', 'SUN'
  ];

  static String getDayByID(int id){
    switch(id){
      case 0:
        return 'MON';
      case 1:
        return 'TUE';
      case 2:
        return 'WED';
      case 3:
        return 'THU';
      case 4:
        return 'FRI';
      case 5:
        return 'SAT';
      case 6:
        return 'SUN';
      default:
        return 'MON';
    }
  }

  static List<AccessRequestModel> get getRequestAccessList {
    return [
      AccessRequestModel(id: '6834c003722289293bd0968a', icon: AppIcons.icPool, title: "Pool"),
      AccessRequestModel(id: '6834c003722289293bd0968b', icon: AppIcons.icGame, title: "Game"),
      AccessRequestModel(id: '6834c003722289293bd0968c', icon: AppIcons.icGym, title: "Gym"),
    ];
  }

  static List<EmergencyContactModel> get emergencyContacts {
    return [
      EmergencyContactModel(id: 1, name: "Isela Trujillo", phoneNumber: "+92 3072215500"),
      EmergencyContactModel(id: 1, name: "Sheraz Ali", phoneNumber: "+92 3072215500"),

    ];
  }
}