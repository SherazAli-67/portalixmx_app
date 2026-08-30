import 'package:cloud_functions/cloud_functions.dart';

class EmergencyService {
  EmergencyService._();

  static final EmergencyService instance = EmergencyService._();

  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<void> sendEmergencyAlert() async {
    await _functions.httpsCallable('sendEmergencyAlert').call();
  }

  String mapFirebaseError(Object error) {
    if (error is FirebaseFunctionsException) {
      return error.message ?? 'Emergency alert failed';
    }
    return error.toString();
  }
}
