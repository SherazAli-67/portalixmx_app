import 'dart:async';

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
import 'datetime_format_helpers.dart';

class RequestAccessProvider extends ChangeNotifier {
  bool addingRequestAccess =  false;
  final List<AccessModel> _allAccessItems = [];
  List<AccessRequestModel> _allAccessRequests  = [];
  List<AccessRequestModel> _filteredAccessRequests  = [];
  StreamSubscription? _requestsSub;

  final _requestsService = AccessRequestService.instance;
  DateTime? dateFrom;
  DateTime? dateTo;
  List<AccessRequestModel> get allAccessRequests => _allAccessRequests;
  List<AccessRequestModel> get filteredAccessRequests => _filteredAccessRequests;
  List<AccessModel> get allAccessItems => _allAccessItems;
  RequestAccessProvider(){
    _listenRequests();
  }

  void _listenRequests() {
    _requestsSub?.cancel();
    _requestsSub = _requestsService.watchAllRequests().listen((requests) {
      _allAccessRequests = requests;
      _sortAccessRequests();
      _applyDateFilter();
    }, onError: (e) {
      debugPrint('RequestAccessProvider: failed to watch access requests: $e');
    });
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
      await _requestsService.createRequest(date: date, time: time, access: accessModel, society: society!,);
      }catch(e){
        debugPrint("Exception while creating access request");
      }
      addingRequestAccess = false;
      notifyListeners();
    }
  }

  Future<void> refreshRequests() async {
    _listenRequests();
  }

  void setDateFrom(DateTime date){
    dateFrom = date;
    _applyDateFilter();
  }

  void setDateTo(DateTime date){
    dateTo = date;
    _applyDateFilter();
  }

  void clearDateRange(){
    dateFrom = null;
    dateTo = null;
    _applyDateFilter();
  }

  void _sortAccessRequests() {
    _allAccessRequests.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
  }

  void _applyDateFilter(){
    _filteredAccessRequests = _allAccessRequests.where((request) {
      return DateTimeFormatHelpers.isDateInRange(request.createdAt, from: dateFrom, to: dateTo);
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    _requestsSub?.cancel();
    super.dispose();
  }
}
