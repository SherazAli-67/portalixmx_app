import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_update_guest_bottomsheet.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';
import 'package:portalixmx_app/services/visitor_service/visitor_service.dart';
import '../core/helpers/bottom_sheet_helper.dart';
import '../presentation/screens/main_menu/main_menu.dart';

class HomeProvider extends ChangeNotifier {
  bool addingGuestVisitor = false;
  bool loadingVisitors = false;
  final _userService = UserService.instance;
  final _visitorService = VisitorService.instance;
  int _selectedTab = 0;

  List<BaseVisitor> _visitors = [];
  List<BaseVisitor> get visitors => _visitors;
  List<GuestVisitor> get guests => _visitors.whereType<GuestVisitor>().toList();
  List<RegularVisitor> get regularVisitors => _visitors.whereType<RegularVisitor>().toList();
  int get selectedTab => _selectedTab;

  HomeProvider() {
    _initVisitorsAndGuests();
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
    await loadVisitors();
  }

  Future<void> loadVisitors() async {
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

      await _visitorService.deleteVisitor(user.userID, visitorID);
      _visitors.removeWhere((v) => v.id == visitorID);
      
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting visitor: $e');
      return false;
    }
  }

  Future<dynamic> onAddGuestTap() async {
    await BottomSheetHelper.showDraggableBottomSheet<dynamic>(
      scaffoldKey: scaffoldKey,
      initialHeight: 0.7,
      child: AddUpdateGuestBottomSheet(),
    );
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
}