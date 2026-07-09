import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/models/community_poll_model.dart';
import '../../core/models/user_model.dart';
import '../../services/community_polls_service/community_polls_service.dart';
import '../../services/user_service/user_service.dart';

class CommunityPollsProvider extends ChangeNotifier {
  bool loadingCommunityPolls = false;
  final _userService = UserService.instance;
  final _pollsService = CommunityPollsService.instance;

  List<CommunityPollModel> _communityPolls = [];

  List<CommunityPollModel> get communityPolls => _communityPolls;

  CommunityPollsProvider() {
    _initCommunityPolls();
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _userService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  void _initCommunityPolls() async {
    try {
      loadingCommunityPolls = true;
      notifyListeners();
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }
      final sid = user.societyID;
      if (sid == null || sid.isEmpty) {
        _communityPolls = [];
      } else {
        _communityPolls = await _pollsService.getPolls(sid);
      }
      loadingCommunityPolls = false;
      notifyListeners();
    } catch (e) {
      loadingCommunityPolls = false;
      notifyListeners();
      debugPrint('Error loading polls: $e');
    }
  }


}
