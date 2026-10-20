import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_complaint_bottomsheet.dart';
import 'package:portalixmx_app/services/complaints_service/complaints_service.dart';
import '../core/models/complaints_model.dart';
import '../core/models/society_model.dart';
import '../core/models/user_model.dart';
import '../services/user_service/user_service.dart';
import 'datetime_format_helpers.dart';

class MaintenanceProvider extends ChangeNotifier {
  bool addingComplaint =  false;
  bool loadingComplaints = false;
  List<ComplaintModel> _allComplaints  = [];
  List<ComplaintModel> _filteredComplaints  = [];
  StreamSubscription? _complaintsSub;

  DateTime? dateFrom;
  DateTime? dateTo;
  final _complaintService = ComplaintsService.instance;
  List<ComplaintModel> get allComplaints => _allComplaints;
  List<ComplaintModel> get filteredComplaints => _filteredComplaints;
  MaintenanceProvider(){
    _listenComplaints();
  }

  void _listenComplaints() {
    loadingComplaints = true;
    notifyListeners();
    _complaintsSub?.cancel();
    _complaintsSub = _complaintService.watchAllComplaints().listen((complaints) {
      _allComplaints = complaints;
      _sortComplaints();
      _applyDateFilter();
      loadingComplaints = false;
      notifyListeners();
    }, onError: (e) {
      loadingComplaints = false;
      notifyListeners();
      debugPrint("Error while watching complaints: ${e.toString()}");
    });
  }

  Future<String?> deleteComplaintByID(String complaintID) async {
    try{
      await _complaintService.deleteComplaintByID(complaintID);
      return null;
    }catch(e){
      return e.toString().replaceFirst('Exception: ', '');
    }
  }

  Future<String?> onAddComplaintTap()async{
    final result = await BottomSheetHelper.showDraggableBottomSheet(
      initialHeight: 0.6,
      scaffoldKey: scaffoldKey, child: AddComplaintBottomSheet(),);
    if(result != null){
      addingComplaint = true;
      notifyListeners();
      String complaintText = result['complaint'];
      List<XFile> complaintFiles = result['files'];

      UserModel? user = await UserService.instance.getCurrentUser();
      if(user  == null) return 'user_not_found_login_again';
      List<String>? imagesUrl;
      if(complaintFiles.isNotEmpty){
        imagesUrl = await _complaintService.uploadComplaintImages(files: complaintFiles);
      }

      SocietyModel? society = await UserService.instance.getSocietyByID(societyID: user.societyID ?? '');
      try{
        await _complaintService.addComplaint(complaintText: complaintText, society: society!, images: imagesUrl);
      }catch(e){
        addingComplaint = false;
        notifyListeners();
        return e.toString().replaceFirst('Exception: ', '');
      }
      addingComplaint = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> refreshComplaints() async {
    _listenComplaints();
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

  void _sortComplaints() {
    _allComplaints.sort((a, b)=> b.createdAt.compareTo(a.createdAt));
  }

  void _applyDateFilter(){
    _filteredComplaints = _allComplaints.where((complaint) {
      return DateTimeFormatHelpers.isDateInRange(complaint.createdAt, from: dateFrom, to: dateTo);
    }).toList();
    notifyListeners();
  }

  @override
  void dispose() {
    _complaintsSub?.cancel();
    super.dispose();
  }
}
