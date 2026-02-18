import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_update_guest_bottomsheet.dart';
import 'package:portalixmx_app/presentation/bottomsheets/directory_guests_sheet.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';
import 'package:portalixmx_app/services/visitor_service/visitor_service.dart';
import '../core/helpers/bottom_sheet_helper.dart';
import '../presentation/screens/main_menu/main_menu.dart';

class HomeProvider extends ChangeNotifier {
  bool addingGuestVisitor = false;
  bool loadingVisitors = false;
  bool loadingDirectoryGuests = false;

  final _userService = UserService.instance;
  final _visitorService = VisitorService.instance;
  int _selectedTab = 0;

  List<BaseVisitor> _visitors = [];
  List<BaseVisitor> _directoryGuests = [];

  List<BaseVisitor> get visitors => _visitors;
  List<BaseVisitor> get directoryGuests => _directoryGuests;

  List<GuestVisitor> get guests => _visitors.whereType<GuestVisitor>().toList();
  List<RegularVisitor> get regularVisitors => _visitors.whereType<RegularVisitor>().toList();
  int get selectedTab => _selectedTab;

  HomeProvider() {
    _initVisitorsAndGuests();
    _initDirectoryGuests();
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      UserModel? user = await _userService.getCurrentUser();
      return user;
    } catch (e) {
      return null;
    }
  }

  void _initVisitorsAndGuests() async {
    try {
      loadingVisitors = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      _visitors = await _visitorService.getVisitors(user.userID);

      loadingVisitors = false;
      notifyListeners();
    } catch (e) {
      loadingVisitors = false;
      notifyListeners();
      debugPrint('Error loading visitors: $e');
    }
  }


  void _initDirectoryGuests() async {
    try {
      loadingDirectoryGuests = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      _directoryGuests = await _visitorService.initDirectoryGuests(user.userID);
      loadingDirectoryGuests = false;
      notifyListeners();
    } catch (e) {
      loadingDirectoryGuests = false;
      notifyListeners();
      debugPrint('Error loading directory visitors: $e');
    }
  }

  Future<bool> addVisitor(BaseVisitor visitor) async {
    try {
      addingGuestVisitor = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      final visitorId = await _visitorService.addVisitor(user.userID, visitor);
      
      final updatedVisitor = visitor is GuestVisitor
          ? visitor.copyWith(id: visitorId)
          : (visitor as RegularVisitor).copyWith(id: visitorId);
      
      _visitors.add(updatedVisitor);
      
      addingGuestVisitor = false;
      notifyListeners();
      return true;
    } catch (e) {
      addingGuestVisitor = false;
      notifyListeners();
      debugPrint('Error adding visitor: $e');
      return false;
    }
  }

  Future<bool> updateVisitor(String visitorID, BaseVisitor updatedVisitor) async {
    try {
      addingGuestVisitor = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      await _visitorService.updateVisitor(user.userID, visitorID, updatedVisitor);
      
      final index = _visitors.indexWhere((v) => v.id == visitorID);
      if (index != -1) {
        _visitors[index] = updatedVisitor;
      }
      
      addingGuestVisitor = false;
      notifyListeners();
      return true;
    } catch (e) {
      addingGuestVisitor = false;
      notifyListeners();
      debugPrint('Error updating visitor: $e');
      return false;
    }
  }

  Future<bool> deleteVisitor(String visitorID) async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      _visitors.removeWhere((v) => v.id == visitorID);
      notifyListeners();
      await _visitorService.deleteVisitor(user.userID, visitorID);
      return true;
    } catch (e) {
      debugPrint('Error deleting visitor: $e');
      return false;
    }
  }

  Future<dynamic> onAddGuestTap() async {
   final result= await BottomSheetHelper.showDraggableListBottomSheet(scaffoldKey: scaffoldKey, contentBuilder: (scrollController, scrollPhysics){
      return DirectoryGuestsSheet(scrollPhysics: scrollPhysics, scrollController: scrollController);
    });

   if(result != null){
     if(result['visitor'] != null){
       await BottomSheetHelper.showDraggableBottomSheet<dynamic>(
         scaffoldKey: scaffoldKey,
         initialHeight: 0.7,
         child: AddUpdateGuestBottomSheet(visitor: result['visitor'] , comingFromGuestDirectory: true,),
       );
     }else if(result['addNewGuest'] != null){
       await BottomSheetHelper.showDraggableBottomSheet<dynamic>(
         scaffoldKey: scaffoldKey,
         initialHeight: 0.7,
         child: AddUpdateGuestBottomSheet(),
       );
     }
   }

   /* await BottomSheetHelper.showDraggableBottomSheet<dynamic>(
      scaffoldKey: scaffoldKey,
      initialHeight: 0.7,
      child: DirectoryGuestsSheet(),
    );*/
  }

  Future<dynamic> onEditVisitorTap(BaseVisitor visitor) async {
    await BottomSheetHelper.showDraggableBottomSheet<dynamic>(
      scaffoldKey: scaffoldKey,
      initialHeight: 0.7,
      child: AddUpdateGuestBottomSheet(
        visitor: visitor,
        isEdit: true,
      ),
    );
  }

  void onTabChange(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  Future<bool> addVisitorToDirectory(BaseVisitor newVisitor) async {
    try {

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      _directoryGuests.add(newVisitor);
      notifyListeners();
      await _visitorService.addVisitorToDirectory(user.userID, newVisitor);
      return true;
    } catch (e) {
      addingGuestVisitor = false;
      notifyListeners();
      debugPrint('Error adding visitor: $e');
      return false;
    }
  }

}