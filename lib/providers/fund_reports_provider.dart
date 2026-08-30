import 'package:flutter/material.dart';
import '../core/models/fund_report_model.dart';
import '../core/models/user_model.dart';
import '../services/fund_reports_service/fund_reports_service.dart';
import '../services/user_service/user_service.dart';

class FundReportsProvider extends ChangeNotifier {
  bool loadingFundReports = false;
  final _userService = UserService.instance;
  final _fundReportsService = FundReportsService.instance;

  List<FundReportModel> _fundReports = [];

  List<FundReportModel> get fundReports => _fundReports;

  FundReportsProvider() {
    _initFundReports();
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      return await _userService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }

  Future<void> _initFundReports() async {
    try {
      loadingFundReports = true;
      notifyListeners();
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('User not found');
      }
      _fundReports = await _fundReportsService.getReports(user.societyID!);
      _fundReports.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      loadingFundReports = false;
      notifyListeners();
    } catch (e) {
      loadingFundReports = false;
      notifyListeners();
      debugPrint('Error loading fund reports: $e');
    }
  }

  Future<void> refresh() => _initFundReports();

}
