class PaymentSubmittedModel {
  final String paymentByUID;
  final DateTime submittedOnDate;
  final DateTime? approvedOnDate;
  final DateTime? rejectedOnDate;
  final String? receipt;
  final String? status;

  PaymentSubmittedModel({
    required this.paymentByUID,
    required this.submittedOnDate,
    this.approvedOnDate,
    this.rejectedOnDate,
    this.receipt,
    this.status,
  });

  bool get isRejected =>
      rejectedOnDate != null || (status != null && status!.toLowerCase() == 'rejected');

  bool get isReceived => approvedOnDate != null || (status != null && status!.toLowerCase() == 'received');

  PaymentSubmittedModel copyWith({
    String? paymentByUID,
    DateTime? submittedOnDate,
    DateTime? approvedOnDate,
    DateTime? rejectedOnDate,
    String? receipt,
    String? status,
    bool clearRejected = false,
    bool clearApproved = false,
  }) {
    return PaymentSubmittedModel(
      paymentByUID: paymentByUID ?? this.paymentByUID,
      submittedOnDate: submittedOnDate ?? this.submittedOnDate,
      approvedOnDate: clearApproved ? null : (approvedOnDate ?? this.approvedOnDate),
      rejectedOnDate: clearRejected ? null : (rejectedOnDate ?? this.rejectedOnDate),
      receipt: receipt ?? this.receipt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'paymentByUID': paymentByUID,
      'submittedOnDate': submittedOnDate.toIso8601String(),
      'approvedOnDate': approvedOnDate?.toIso8601String(),
      'rejectedOnDate': rejectedOnDate?.toIso8601String(),
      'receipt': receipt,
      'status': status ?? (isReceived
          ? 'received'
          : isRejected
              ? 'rejected'
              : 'submitted'),
    };
  }

  factory PaymentSubmittedModel.fromMap(Map<String, dynamic> map) {
    return PaymentSubmittedModel(
      paymentByUID: map['paymentByUID'] ?? '',
      submittedOnDate: DateTime.parse(map['submittedOnDate']),
      approvedOnDate: map['approvedOnDate'] != null
          ? DateTime.tryParse(map['approvedOnDate'].toString())
          : null,
      rejectedOnDate: map['rejectedOnDate'] != null
          ? DateTime.tryParse(map['rejectedOnDate'].toString())
          : null,
      receipt: map['receipt'],
      status: map['status']?.toString(),
    );
  }
}
