import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/payment_submitted_model.dart';
import '../../core/models/payment_model.dart';
import '../../core/models/user_model.dart' show UserModel;
import '../../l10n/app_localizations.dart';
import '../../services/payments_service/payments_service.dart';
import '../../services/user_service/user_service.dart';
import '../datetime_format_helpers.dart';

class PaymentProvider extends ChangeNotifier{
  final _paymentsService = PaymentsService.instance;
  bool loadingPayments = false;
  bool addingPayment = false;
  String? error;
  int selectedFilterTab = 0;
  bool updatingPayment = false;

  List<PaymentModel> _payments = [];
  List<PaymentModel> get payments => _payments;
  Map<String, PaymentStatus> _paymentStatuses = {};

  PaymentProvider(){
    _initPayments();
  }

  DateTime? dateFrom;
  DateTime? dateTo;
  String? selectedPaymentStatusFilter;

  List<String> getStatusList(AppLocalizations localization){
    return [
      localization.pending,
      localization.submitted,
      localization.received,
    ];
  }

  PaymentStatus statusFor(String paymentID) => _paymentStatuses[paymentID] ?? .pending;

  List<PaymentModel> getFilteredPayments(AppLocalizations l10n) {
    PaymentStatus? statusFilter;
    if (selectedPaymentStatusFilter == l10n.pending) {
      statusFilter = PaymentStatus.pending;
    } else if (selectedPaymentStatusFilter == l10n.submitted) {
      statusFilter = PaymentStatus.submitted;
    } else if (selectedPaymentStatusFilter == l10n.received) statusFilter = PaymentStatus.received;
    final filtered = _payments.where((p) {
      if (!DateTimeFormatHelpers.isDateInRange(p.dateTime, from: dateFrom, to: dateTo)) return false;
      if (statusFilter != null && statusFor(p.paymentID) != statusFilter) return false;
      return true;
    }).toList();
    filtered.sort((a, b)=> b.dateTime.compareTo(a.dateTime));
    return filtered;
  }

  Future<void> _initPayments() async {
    loadingPayments = true;
    notifyListeners();
    try{
      UserModel? user=  await UserService.instance.getCurrentUser();
      if(user == null){
        error = "User not found";
        loadingPayments = false;
        notifyListeners();
        return;
      }
      _payments = await _paymentsService.getPayments(user.societyID?? '');
      _payments.sort((a, b)=> b.dateTime.compareTo(a.dateTime));
      await _loadPaymentStatuses();
    }catch(e){
      error = e.toString();
    }
    loadingPayments = false;
    notifyListeners();
  }

  Future<void> _loadPaymentStatuses() async {
    final entries = await Future.wait(_payments.map((payment) async {
      final status = await _paymentsService.getPaymentStatus(paymentID: payment.paymentID);
      return MapEntry(payment.paymentID, status);
    }));
    _paymentStatuses = Map.fromEntries(entries);
  }

  Future<void> refreshPayments() async {
    await _initPayments();
  }

  void setDateFrom(DateTime date){
    dateFrom = date;
    notifyListeners();
  }

  void setDateTo(DateTime date){
    dateTo = date;
    notifyListeners();
  }

  void clearDateRange(){
    dateFrom = null;
    dateTo = null;
    notifyListeners();
  }

  void onChangeStatusFilterTap(String val){
    selectedPaymentStatusFilter = val;
    notifyListeners();
  }

  Future<String?> updatePayment(PaymentModel updatedPayment) async {
    updatingPayment = true;
    notifyListeners();
    try{
      UserModel? user=  await UserService.instance.getCurrentUser();
      if(user == null) {
       return 'User not found';
      }

      String receipt = await _paymentsService.uploadPaymentReceipt(receipt: updatedPayment.receipt!);
      PaymentSubmittedModel paymentSubmitted = PaymentSubmittedModel(paymentByUID: user.userID, submittedOnDate: DateTime.now().toUtc(), receipt: receipt);
      await _paymentsService.submitPaymentToAdmin(paymentID: updatedPayment.paymentID, paymentSubmitted: paymentSubmitted);
      int index = _payments.indexWhere((payment) => payment.paymentID == updatedPayment.paymentID);
      _payments[index] = updatedPayment.copyWith(receipt: receipt);
      _paymentStatuses[updatedPayment.paymentID] = .submitted;
      updatingPayment = false;
      notifyListeners();
      return null;
    }catch(e){
      updatingPayment = false;
      notifyListeners();
      return e.toString();
    }
  }
}
