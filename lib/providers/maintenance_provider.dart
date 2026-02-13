import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_complaint_bottomsheet.dart';
import 'package:portalixmx_app/services/complaints_service/complaints_service.dart';
import '../core/models/complaints_api_response.dart';

class MaintenanceProvider extends ChangeNotifier {
  bool addingComplaint =  false;
  List<ComplaintModel> _allComplaints  = [];
  final _complaintService = ComplaintsService.instance;
  List<ComplaintModel> get allComplaints => _allComplaints;

  MaintenanceProvider(){
    _initComplaints();
  }
  Future<bool> addComplaint({required String token, required String complaint, required List<File> files}) async{
    bool result = false;
    return result;
  }

  Future<Map<String, dynamic>?> getAllComplaints() async{
    return null;
  }

  Future<bool> deleteComplaintByID(String complaintID) async {
    bool result = false;
    return result;
  }

  Future<String?> onAddComplaintTap()async{
    final result = await BottomSheetHelper.showDraggableBottomSheet(scaffoldKey: scaffoldKey, child: AddComplaintBottomSheet(),);
    if(result != null){
      addingComplaint = true;
      notifyListeners();

      String complaintText = result['complaint'];
      List<XFile> complaintFiles = result['files'];

      if(complaintFiles.isNotEmpty){
      }

      try{
        ComplaintModel? complaint = await _complaintService.addComplaint(complaintText: complaintText,);
        if(complaint != null){
          _allComplaints.add(complaint);
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
      _allComplaints = await _complaintService.getAllComplaints();
      notifyListeners();
    }catch(e){
      debugPrint("Error while fetching complaints: ${e.toString()}");
    }
  }
}