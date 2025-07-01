// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PortalixMX';

  @override
  String get residentLogin => 'Resident Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get forgetPassword => 'Forget your password';

  @override
  String welcomeMessage(Object name) {
    return 'Bienvenido $name';
  }

  @override
  String get regularVisitors => 'Visitantes Regulares';

  @override
  String get guest => 'Invitado';

  @override
  String get accessRequests => 'Solicitudes de Acceso';

  @override
  String get poolAccess => 'Acceso a la Piscina';

  @override
  String get add => 'Agregar';

  @override
  String get twoStepVerification => '2 Step Verification';

  @override
  String get twoStepVerificationDescription =>
      'Enter the 2 step verification code sent on your email address';

  @override
  String get otp => 'OTP';

  @override
  String get submit => 'Submit';

  @override
  String get needHelp => 'Need Help';

  @override
  String get home => 'Home';

  @override
  String get payments => 'Payments';

  @override
  String get maintenance => 'Maintenance';

  @override
  String get access => 'Access';

  @override
  String get menu => 'Menu';

  @override
  String get regularVisitor => 'Regular Visitor';

  @override
  String get requestedTime => 'REQUESTED TIME';

  @override
  String get accessFor => 'Access For';

  @override
  String get teacher => 'Teacher';

  @override
  String get accessApprovedDate => 'Access Approved Date';

  @override
  String get contactNum => 'Contact No';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get shareKey => 'Share Key';

  @override
  String get qrCode => 'QR CODE';

  @override
  String get paymentsAndBilling => 'Payments & Billing';

  @override
  String get currentService => 'Current Service';

  @override
  String get otherServices => 'Other Services';

  @override
  String get serviceName => 'Service Name';

  @override
  String get cleaningOfCommonAreas => 'Cleaning of common areas';

  @override
  String get garbageCollection => 'Garbage Collection';
}
