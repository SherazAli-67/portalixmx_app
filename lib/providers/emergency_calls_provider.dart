import 'dart:async';

import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/bottom_sheet_helper.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/presentation/bottomsheets/select_emergency_contacts_sheet.dart';
import 'package:portalixmx_app/presentation/screens/main_menu/main_menu.dart';
import 'package:portalixmx_app/services/emergency_service/emergency_service.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';

class EmergencyCallsProvider extends ChangeNotifier {
  final _userService = UserService.instance;
  final _emergencyService = EmergencyService.instance;

  UserModel? _user;
  List<UserModel> _contacts = [];
  List<UserModel> _societyResidents = [];
  Timer? _holdTimer;
  DateTime? _holdStart;

  bool loadingContacts = false;
  bool updatingContacts = false;
  bool isSending = false;
  double holdProgress = 0;

  List<UserModel> get contacts => _contacts;
  UserModel? get user => _user;

  EmergencyCallsProvider() {
    _init();
  }

  Future<void> _init() async {
    loadingContacts = true;
    notifyListeners();
    try {
      _user = await _userService.getCurrentUser();
      if (_user != null) {
        _contacts = await _userService.getResidentsByIds(_user!.emergencyContacts);
      }
    } catch (e) {
      debugPrint('Error while fetching emergency contacts: ${e.toString()}');
    }
    loadingContacts = false;
    notifyListeners();
  }

  Future<void> onAddContactsTap(BuildContext context) async {
    try {
      _user ??= await _userService.getCurrentUser();
      if (_user == null) return;
      _societyResidents = await _userService.getSocietyResidents(societyID: _user!.societyID ?? '');
    } catch (e) {
      debugPrint('Error while fetching residents: ${e.toString()}');
      _societyResidents = [];
    }

    if (!context.mounted) return;

    final result = await BottomSheetHelper.showDraggableListBottomSheet<List<String>>(
      scaffoldKey: scaffoldKey,
      context: context,
      initialHeight: 0.7,
      contentBuilder: (scrollController, scrollPhysics) {
        return SelectEmergencyContactsSheet(
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          residents: _societyResidents,
          initiallySelectedIds: _contacts.map((c) => c.userID).toSet(),
        );
      },
    );

    if (result == null) return;
    await _saveContacts(result);
  }

  Future<void> removeContact(String userId) async {
    final updatedIds = _contacts.where((c) => c.userID != userId).map((c) => c.userID).toList();
    await _saveContacts(updatedIds);
  }

  Future<void> _saveContacts(List<String> contactIds) async {
    updatingContacts = true;
    notifyListeners();
    try {
      await _userService.updateEmergencyContacts(contactIds: contactIds);
      _contacts = await _userService.getResidentsByIds(contactIds);
      _user = _user?.copyWith(emergencyContacts: contactIds);
    } catch (e) {
      debugPrint('Error while saving emergency contacts: ${e.toString()}');
    }
    updatingContacts = false;
    notifyListeners();
  }

  void startHold({required VoidCallback onComplete}) {
    if (isSending || _contacts.isEmpty) return;
    cancelHold();
    _holdStart = DateTime.now();
    holdProgress = 0;
    notifyListeners();
    _holdTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final elapsed = DateTime.now().difference(_holdStart!).inMilliseconds;
      holdProgress = (elapsed / 3000).clamp(0.0, 1.0);
      notifyListeners();
      if (holdProgress >= 1) {
        timer.cancel();
        _holdTimer = null;
        isSending = true;
        notifyListeners();
        onComplete();
      }
    });
  }

  void cancelHold() {
    _holdTimer?.cancel();
    _holdTimer = null;
    if (!isSending) {
      holdProgress = 0;
      notifyListeners();
    }
  }

  Future<String?> sendEmergencyAlert() async {
    if (_contacts.isEmpty) {
      isSending = false;
      holdProgress = 0;
      notifyListeners();
      return 'empty';
    }
    isSending = true;
    notifyListeners();
    try {
      await _emergencyService.sendEmergencyAlert();
      holdProgress = 0;
      isSending = false;
      notifyListeners();
      return null;
    } catch (e) {
      holdProgress = 0;
      isSending = false;
      notifyListeners();
      return _emergencyService.mapFirebaseError(e);
    }
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }
}
