import 'package:cloud_functions/cloud_functions.dart';
import 'package:portalixmx_app/core/models/zkbio_qr_model.dart';

class ZkbioAccessService {
  ZkbioAccessService._();

  static final ZkbioAccessService instance = ZkbioAccessService._();

  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<ZkbioQrModel> getResidentQr() async {
    final result = await _functions.httpsCallable('getResidentQr').call();
    return ZkbioQrModel.fromMap(Map<String, dynamic>.from(result.data as Map));
  }

  Future<ZkbioQrModel> registerGuestZkAccess(String visitorId) async {
    final result = await _functions.httpsCallable('registerGuestZkAccess').call({
      'visitorId': visitorId,
    });
    return ZkbioQrModel.fromMap(Map<String, dynamic>.from(result.data as Map));
  }

  Future<ZkbioQrModel> refreshGuestQr(String visitorId) async {
    final result = await _functions.httpsCallable('refreshGuestQr').call({
      'visitorId': visitorId,
    });
    return ZkbioQrModel.fromMap(Map<String, dynamic>.from(result.data as Map));
  }

  Future<void> checkoutGuestZkAccess(String visitorId) async {
    await _functions.httpsCallable('checkoutGuestZkAccess').call({
      'visitorId': visitorId,
    });
  }

  String mapFirebaseError(Object error) {
    if (error is FirebaseFunctionsException) {
      return error.message ?? 'ZKBio access failed';
    }
    return error.toString();
  }
}
