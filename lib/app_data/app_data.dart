import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/access_request_model.dart';
import 'package:portalixmx_app/models/emergency_contact_model.dart';
import 'package:portalixmx_app/res/app_icons.dart';

class AppData {
  static  List<String> getDays(BuildContext context) {
    return [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday
    ];
  }

  static String getDayByID(BuildContext context, int id){
    switch(id){
      case 0:
        return AppLocalizations.of(context)!.monday;
      case 1:
        return AppLocalizations.of(context)!.tuesday;
      case 2:
        return AppLocalizations.of(context)!.wednesday;
      case 3:
        return AppLocalizations.of(context)!.thursday;
      case 4:
        return AppLocalizations.of(context)!.friday;
      case 5:
        return AppLocalizations.of(context)!.saturday;
      case 6:
        return AppLocalizations.of(context)!.sunday;
      default:
        return AppLocalizations.of(context)!.monday;
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