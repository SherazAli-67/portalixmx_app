import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_complaint_bottomsheet.dart';
import 'package:portalixmx_app/services/complaints_service/complaints_service.dart';
import '../core/models/complaints_model.dart';

class MaintenanceProvider extends ChangeNotifier {
  bool addingComplaint =  false;
  bool loadingComplaints = false;
  List<ComplaintModel> _allComplaints  = [];
  final _complaintService = ComplaintsService.instance;
  List<ComplaintModel> get allComplaints => _allComplaints;

  MaintenanceProvider(){
    _initComplaints();
  }


  Future<String?> deleteComplaintByID(String complaintID) async {
    try{
      debugPrint("onDelete occurred");
      _allComplaints.removeWhere((complaint) => complaint.id == complaintID);
      notifyListeners();
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
      loadingComplaints = true;
      notifyListeners();

      _allComplaints = await _complaintService.getAllComplaints();
      notifyListeners();
    }catch(e){
      debugPrint("Error while fetching complaints: ${e.toString()}");
    }

    loadingComplaints = false;
    notifyListeners();

  }
}