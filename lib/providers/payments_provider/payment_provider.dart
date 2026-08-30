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

  PaymentProvider(){
    _initPayments();
  }

  DateTime? dateFrom;
  DateTime? dateTo;
  String? selectedPaymentStatusFilter;

  List<String> getStatusList(AppLocalizations localization){
    return [
      localization.pending,
      localization.received,
    ];
  }

  List<PaymentModel> getFilteredPayments(AppLocalizations l10n) {
    PaymentStatus? statusFilter;
    if (selectedPaymentStatusFilter == l10n.pending) {
      statusFilter = PaymentStatus.pending;
    } else if (selectedPaymentStatusFilter == l10n.received) statusFilter = PaymentStatus.received;
    final filtered = _payments.where((p) {
      if (!DateTimeFormatHelpers.isDateInRange(p.dateTime, from: dateFrom, to: dateTo)) return false;
      if (statusFilter != null && p.paymentStatus != statusFilter) return false;
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
    }catch(e){
      error = e.toString();
    }
    loadingPayments = false;
    notifyListeners();
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
      await _paymentsService.updatePayment(payment: updatedPayment.copyWith(receipt: receipt));
      updatingPayment = false;
      notifyListeners();
      return null;
    }catch(e){
      updatingPayment = false;
      notifyListeners();
      return e.toString();
    }
  }

  Future<PaymentStatus?> getPaymentStatus({required String paymentID}) async {
    try{

   return await _paymentsService.getPaymentStatus(paymentID: paymentID);
    /* if(paymentSubmitted == null){
       return PaymentStatus.pending;
     }
     if(paymentSubmitted.approvedOnDate == null){
       return PaymentStatus.received;
     }else{
       return PaymentStatus.submitted;
     }*/

    }catch(e){
      debugPrint("Failed to get payment: ${e.toString()}");
      return null;
    }
  }
}
