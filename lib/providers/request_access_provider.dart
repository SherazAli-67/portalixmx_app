import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/core/models/access_model.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/request_for_access_sheet.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/services/access_requests_service/access_request_service.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';
import '../core/models/access_request_model.dart';

class RequestAccessProvider extends ChangeNotifier {
  bool addingRequestAccess =  false;
  final List<AccessModel> _allAccessItems = [];
  List<AccessRequestModel> _allAccessRequests  = [];
  List<AccessRequestModel> _filteredAccessRequests  = [];

  final _requestsService = AccessRequestService.instance;
  final List<String> _filters = ['All', 'Week', 'Month',];
  String _selectedFilter = 'All';
  List<AccessRequestModel> get allAccessRequests => _allAccessRequests;
  List<AccessRequestModel> get filteredAccessRequests => _filteredAccessRequests;
  List<AccessModel> get allAccessItems => _allAccessItems;
  List<String> get filters => _filters;
  String get selectedFilter => _selectedFilter;
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
        UserModel? user = await UserService.instance.getCurrentUser();
        if(user  == null) return;

        SocietyModel? society = await UserService.instance.getSocietyByID(societyID: user.societyID ?? '');
      AccessRequestModel accessRequest =  await _requestsService.createRequest(date: date, time: time, access: accessModel, society: society!,);
      _allAccessRequests.add(accessRequest);
      }catch(e){
        debugPrint("Exception while creating access request");
      }
      addingRequestAccess = false;
      notifyListeners();
    }
  }

  Future<void> _initRequests() async {
    try {
      _allAccessRequests = await _requestsService.getAllRequests();
      _filteredAccessRequests = List<AccessRequestModel>.from(_allAccessRequests);
      notifyListeners();
    } catch (e) {
      debugPrint('RequestAccessProvider: failed to fetch access items: $e');
    }
  }

  Future<void> refreshRequests() async {
    await _initRequests();
    onFilterUpdated(_selectedFilter);
  }

  void onFilterUpdated(dynamic val){
    _selectedFilter = val;
    if(_selectedFilter == 'All'){
      _filteredAccessRequests = _allAccessRequests;
    }else if(_selectedFilter == 'Week'){
      _filteredAccessRequests = _getComplaintsOfCurrentWeek();
    }else{
      _filteredAccessRequests = _getComplaintsOfCurrentMonth();
    }
    notifyListeners();
  }

  List<AccessRequestModel> _getComplaintsOfCurrentWeek() {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day).add(const Duration(days: 1));
    final start = end.subtract(const Duration(days: 7));

    return _allAccessRequests.where((complaint) {
      return complaint.createdAt.isAfter(start) &&
          complaint.createdAt.isBefore(end);
    }).toList();
  }

  List<AccessRequestModel> _getComplaintsOfCurrentMonth() {
    final now = DateTime.now();

    final start = DateTime(now.year, now.month, 1);

    final end = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 1)
        : DateTime(now.year + 1, 1, 1);

    return _allAccessRequests.where((complaint) {
      return complaint.createdAt.isAfter(start) &&
          complaint.createdAt.isBefore(end);
    }).toList();
  }
}