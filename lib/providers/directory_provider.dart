import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/add_update_guest_bottomsheet.dart';
import 'package:portalixmx_app/services/directory_service/directory_service.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';
import '../core/helpers/bottom_sheet_helper.dart';
import '../presentation/screens/main_menu/main_menu.dart';

class DirectoryProvider extends ChangeNotifier {
  bool loadingDirectoryGuests = false;
  bool addingUpdatingGuestVisitor = false;
  final _userService = UserService.instance;
  final _directoryService = DirectoryService.instance;

  List<BaseVisitor> _directoryGuests = [];

  List<BaseVisitor> get directoryGuests => _directoryGuests;


  DirectoryProvider() {
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

  void _initDirectoryGuests() async {
    try {
      loadingDirectoryGuests = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      _directoryGuests = await _directoryService.initDirectoryGuests(user.userID);
      loadingDirectoryGuests = false;
      notifyListeners();
    } catch (e) {
      loadingDirectoryGuests = false;
      notifyListeners();
      debugPrint('Error loading visitors: $e');
    }
  }


  Future<bool> updateVisitor(String visitorID, BaseVisitor updatedVisitor) async {
    try {
      addingUpdatingGuestVisitor = true;
      notifyListeners();

      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }

      await _directoryService.updateVisitor(user.userID, visitorID, updatedVisitor);
      
      final index = _directoryGuests.indexWhere((v) => v.id == visitorID);
      if (index != -1) {
        _directoryGuests[index] = updatedVisitor;
      }
      
      addingUpdatingGuestVisitor = false;
      notifyListeners();
      return true;
    } catch (e) {
      addingUpdatingGuestVisitor = false;
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

      _directoryGuests.removeWhere((v) => v.id == visitorID);
      notifyListeners();
      await _directoryService.deleteVisitor(user.userID, visitorID);
      return true;
    } catch (e) {
      debugPrint('Error deleting visitor: $e');
      return false;
    }
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

}