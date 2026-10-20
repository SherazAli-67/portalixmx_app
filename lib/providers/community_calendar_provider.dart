import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_app/core/models/community_event_model.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/services/community_service/community_service.dart';
import 'package:portalixmx_app/services/user_service/user_service.dart';

class CommunityCalendarProvider extends ChangeNotifier {
  bool loadingCommunityEvents = false;
  final _userService = UserService.instance;
  final _directoryService = CommunityService.instance;
  StreamSubscription? _eventsSub;

  List<CommunityEventModel> _communityEvents = [];

  List<CommunityEventModel> get communityEvents => _communityEvents;

  CommunityCalendarProvider() {
    _listenCommunityEvents();
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _userService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  Future<void> _listenCommunityEvents() async {
    try {
      loadingCommunityEvents = true;
      notifyListeners();
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }
      final societyID = user.societyID ?? '';
      _eventsSub?.cancel();
      _eventsSub = _directoryService.watchCommunityEvents(societyID).listen((events) {
        _communityEvents = events;
        loadingCommunityEvents = false;
        notifyListeners();
      }, onError: (e) {
        loadingCommunityEvents = false;
        notifyListeners();
        debugPrint('Error loading events: $e');
      });
    } catch (e) {
      loadingCommunityEvents = false;
      notifyListeners();
      debugPrint('Error loading events: $e');
    }
  }

  @override
  void dispose() {
    _eventsSub?.cancel();
    super.dispose();
  }
}
