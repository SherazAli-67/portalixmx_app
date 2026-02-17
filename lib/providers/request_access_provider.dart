import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/core/models/access_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/request_for_access_sheet.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/services/access_requests_service/access_request_service.dart';
import '../core/models/access_request_model.dart';

class RequestAccessProvider extends ChangeNotifier {
  bool addingRequestAccess =  false;
  final List<AccessModel> _allAccessItems = [];
  List<AccessRequestModel> _allAccessRequests  = [];
  final _requestsService = AccessRequestService.instance;

  List<AccessRequestModel> get allAccessRequests => _allAccessRequests;
  List<AccessModel> get allAccessItems => _allAccessItems;

  RequestAccessProvider(){
    _initRequests();
  }

  void onAddRequestTap() async{
    final result = await BottomSheetHelper.showDraggableListBottomSheet(
      scaffoldKey: scaffoldKey,
      contentBuilder: (scrollController, scrollPhysics) => RequestForAccessSheet(scrollController: scrollController, scrollPhysics: scrollPhysics),
    );
    if(result != null){
      addingRequestAccess = true;
      notifyListeners();
      DateTime date = result['selectedDate'];
      TimeOfDay time = result['selectedTime'];
      AccessModel accessModel = result['requestedAccess'];

      try{
      AccessRequestModel accessRequest =  await _requestsService.createRequest(date: date, time: time, access: accessModel);
      _allAccessRequests.add(accessRequest);
      }catch(e){
        debugPrint("Exception while creating access request");
      }
      addingRequestAccess = false;
      notifyListeners();
    }
  }

  void _initRequests() async {
    try {
      _allAccessRequests = await _requestsService.getAllRequests();
      notifyListeners();
    } catch (e) {
      debugPrint('RequestAccessProvider: failed to fetch access items: $e');
    }
  }

}