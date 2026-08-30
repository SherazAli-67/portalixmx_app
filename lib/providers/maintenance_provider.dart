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

  DateTime? dateFrom;
  DateTime? dateTo;
  final _complaintService = ComplaintsService.instance;
  List<ComplaintModel> get allComplaints => _allComplaints;
  List<ComplaintModel> get filteredComplaints => _filteredComplaints;
  MaintenanceProvider(){
    _initComplaints();
  }

  Future<String?> deleteComplaintByID(String complaintID) async {
    try{
      _allComplaints.removeWhere((complaint) => complaint.id == complaintID);
      _applyDateFilter();
      await _complaintService.deleteComplaintByID(complaintID);
      return null;
    }catch(e){
      return e.toString();
    }
  }

  Future<String?> onAddComplaintTap()async{
    final result = await BottomSheetHelper.showDraggableBottomSheet(scaffoldKey: scaffoldKey, child: AddComplaintBottomSheet(),);
    if(result != null){
      addingComplaint = true;
      notifyListeners();
      String complaintText = result['complaint'];
      List<XFile> complaintFiles = result['files'];

      UserModel? user = await UserService.instance.getCurrentUser();
      if(user  == null) return 'User not found, Login again';
      List<String>? imagesUrl;
      if(complaintFiles.isNotEmpty){
        imagesUrl = await _complaintService.uploadComplaintImages(files: complaintFiles);
      }

      SocietyModel? society = await UserService.instance.getSocietyByID(societyID: user.societyID ?? '');
      try{
        ComplaintModel? complaint = await _complaintService.addComplaint(complaintText: complaintText, society: society!, images: imagesUrl);
        if(complaint != null){
          _allComplaints.add(complaint);
          _sortComplaints();
          _applyDateFilter();
        }
        addingComplaint = true;
        notifyListeners();
      }catch(e){
        return e.toString();
      }
    }
    return null;
  }

  Future<void> _initComplaints() async {
    try{
      loadingComplaints = true;
      notifyListeners();

      _allComplaints = await _complaintService.getAllComplaints();
      _sortComplaints();
      _applyDateFilter();
    }catch(e){
      debugPrint("Error while fetching complaints: ${e.toString()}");
    }

    loadingComplaints = false;
    notifyListeners();

  }

  Future<void> refreshComplaints() async {
    await _initComplaints();
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
}
