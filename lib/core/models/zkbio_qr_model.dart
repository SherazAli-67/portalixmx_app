class ZkbioQrModel {
  final String qrPayload;
  final DateTime fetchedAt;
  final String? zkVisEmpPin;
  final String? zkCertNum;

  const ZkbioQrModel({
    required this.qrPayload,
    required this.fetchedAt,
    this.zkVisEmpPin,
    this.zkCertNum,
  });

  factory ZkbioQrModel.fromMap(Map<String, dynamic> map) {
    return ZkbioQrModel(
      qrPayload: map['qrPayload'] as String,
      fetchedAt: DateTime.parse(map['fetchedAt'] as String),
      zkVisEmpPin: map['zkVisEmpPin'] as String?,
      zkCertNum: map['zkCertNum'] as String?,
    );
  }
}
