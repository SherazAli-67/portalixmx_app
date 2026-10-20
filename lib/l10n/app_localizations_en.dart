// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Portalixmx';

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
  String get selectSociety => 'Select Society';

  @override
  String get failedToLoadSocieties =>
      'Unable to load societies. Please try again.';

  @override
  String get retry => 'Retry';

  @override
  String accountRequestPending(String societyName) {
    return 'Your resident request for $societyName is pending. You will be notified as the admin update your request';
  }

  @override
  String welcomeMessage(Object name) {
    return 'Welcome $name';
  }

  @override
  String get regularVisitors => 'Regular Visitors';

  @override
  String get guest => 'Guest';

  @override
  String get year => 'Year';

  @override
  String get pending => 'Pending';

  @override
  String get approved => 'Approved';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get paymentFor => 'Payment for';

  @override
  String get status => 'Status';

  @override
  String get description => 'Description';

  @override
  String get amount => 'Amount';

  @override
  String get receipt => 'Payment Receipt';

  @override
  String get received => 'Received';

  @override
  String get submitted => 'Submitted';

  @override
  String get paymentDetail => 'Payment Details';

  @override
  String get accessRequests => 'Access Requests';

  @override
  String get poolAccess => 'Pool Access';

  @override
  String get add => 'Add';

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

  @override
  String get complaint => 'Complaint';

  @override
  String get uploadPhotos => 'Upload Photos';

  @override
  String get openCamera => 'Open Camera';

  @override
  String get requestAccess => 'Request Access';

  @override
  String get viewProfile => 'View Profile';

  @override
  String get directory => 'Directory';

  @override
  String get communityCalendar => 'Community Calendar';

  @override
  String get communityPolls => 'Community Polls';

  @override
  String pollEndsAt(String when) {
    return 'Ends $when';
  }

  @override
  String get pollVote => 'Vote';

  @override
  String get pollAlreadyVoted => 'You have already voted';

  @override
  String get pollEnded => 'This poll has ended';

  @override
  String get pollVoteFailed => 'Could not submit vote';

  @override
  String get pollSelectOption => 'Please select an option';

  @override
  String get guards => 'Guards';

  @override
  String get carPooling => 'Car Pooling';

  @override
  String get emergencyCalls => 'Emergency Calls';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get logout => 'Logout';

  @override
  String get search => 'Search';

  @override
  String get guardTracking => 'Guard Tracking';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get emergencyContacts => 'Emergency Contacts';

  @override
  String get vehicleInformation => 'Vehicle Information';

  @override
  String get vehicleName => 'Vehicle Name';

  @override
  String get licensePlateNumber => 'License Plate Number';

  @override
  String get registrationNumber => 'Registration Number';

  @override
  String get update => 'Update';

  @override
  String get color => 'Color';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String updateYour(Object userInfo) {
    return 'Update your $userInfo';
  }

  @override
  String get addGuest => 'Add Guest';

  @override
  String get deleteComplaint => 'Delete Complaint';

  @override
  String get profileInfoUpdated => 'Profile information updated';

  @override
  String get profileInfoUpdateFailed =>
      'Profile updating failed, Please try again';

  @override
  String get show => 'Show';

  @override
  String get hide => 'Hide';

  @override
  String get deleteVisitor => 'Delete Visitor';

  @override
  String get deleteGuest => 'Delete Guest';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get editGuest => 'Edit Guest';

  @override
  String get carPlateNumber => 'Car Plate Number';

  @override
  String get vehicleModel => 'Vehicle Model';

  @override
  String get time => 'Time';

  @override
  String get date => 'Date';

  @override
  String get dateFrom => 'Date From';

  @override
  String get dateTo => 'Date To';

  @override
  String hasBeenEditedMessage(Object name) {
    return '$name has been updated';
  }

  @override
  String hasBeenAddedMessage(Object guestType, Object name) {
    return '$name has been added as a $guestType';
  }

  @override
  String accessRequestPending(Object accessTitle) {
    return 'The request for $accessTitle is already in pending state';
  }

  @override
  String accessRequestSubmitted(Object accessTitle) {
    return 'The request for $accessTitle is submitted to Portalix Admin';
  }

  @override
  String get createAccount => 'Create Account';

  @override
  String get createAccountDescription =>
      'Create account with Portalixmx and get started with the society management';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? ';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account? ';

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get completeProfileDescription =>
      'Please provide the rest information to complete your profile';

  @override
  String get additionalDetails => 'Additional Details';

  @override
  String get pleaseEnterName => 'Please enter name';

  @override
  String get pleaseEnterContactNumber => 'Please enter contact number';

  @override
  String get pleaseEnterCarPlateNumber => 'Please enter car plate number';

  @override
  String get pleaseEnterVehicleModel => 'Please enter vehicle model';

  @override
  String get pleaseEnterColor => 'Please enter color';

  @override
  String get pleaseSelectFromDateTime => 'Please select from date and time';

  @override
  String get pleaseSelectToDateTime => 'Please select to date and time';

  @override
  String get toDateTimeMustBeAfterFromDateTime =>
      'To date/time must be after from date/time';

  @override
  String get pleaseSelectAtLeastOneDay =>
      'Please select at least one day with time';

  @override
  String get visitorAddedSuccessfully => 'Visitor added successfully';

  @override
  String get visitorUpdatedSuccessfully => 'Visitor updated successfully';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get error => 'Error';

  @override
  String get all => 'All';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get automaticVisitorCode => 'Visitor Code';

  @override
  String get generateAccessCode => 'Generate Access Code';

  @override
  String get myAccessQr => 'My Access QR';

  @override
  String get myAccessQrDescription =>
      'Show this QR code at the door reader to enter the community.';

  @override
  String get refreshQr => 'Refresh QR';

  @override
  String get shareQrCode => 'Share QR Code';

  @override
  String get zkbioNotConfigured =>
      'Door access is not configured for your society yet.';

  @override
  String get accountNotApprovedForQr =>
      'Your account must be approved by the society admin before you can use access QR.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get guestAccessQr => 'Guest Access QR';

  @override
  String get guestQrShowAtDoor =>
      'Show this QR at the door reader during the visit window.';

  @override
  String get guestQrUnavailable => 'Unable to load guest access QR.';

  @override
  String get guestVisitEnded => 'This guest visit has ended.';

  @override
  String get guestQrOutsideWindow =>
      'Guest QR is only available during the scheduled visit window.';

  @override
  String get close => 'Close';

  @override
  String get fundManagement => 'Fund Management';

  @override
  String get createFundReport => 'Create Fund Report';

  @override
  String get reportTitle => 'Report Title';

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get expenseLabel => 'Expense Label';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get balance => 'Balance';

  @override
  String get note => 'Note';

  @override
  String get publishReport => 'Publish Report';

  @override
  String get saveAsDraft => 'Save as Draft';

  @override
  String get published => 'Published';

  @override
  String get draft => 'Draft';

  @override
  String get emptyFundReportsMsg => 'No fund reports yet';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String get noExpenses => 'No expenses listed';

  @override
  String get emergencyCall => 'EMERGENCY CALL';

  @override
  String get removeContact => 'Remove Contact';

  @override
  String get selectEmergencyContacts => 'Select Emergency Contacts';

  @override
  String get saveContacts => 'Save';

  @override
  String get emergencyAlertSent => 'Emergency notification sent';

  @override
  String get emergencyAlertFailed => 'Failed to send emergency alert';

  @override
  String get addEmergencyContactsFirst => 'Add emergency contacts first';

  @override
  String get noResidentsFound => 'No residents found';

  @override
  String get noEmergencyContacts => 'No emergency contacts';

  @override
  String get holdToSendEmergency => 'Hold for 3 seconds to send';

  @override
  String get refresh => 'Refresh';

  @override
  String get society => 'Society';

  @override
  String get accountStillPending => 'Your account is still pending approval';

  @override
  String get unableToRefreshStatus =>
      'Unable to refresh status. Please try again.';

  @override
  String get guestsDirectory => 'Guests Directory';

  @override
  String get noVisitorFound => 'No visitor found';

  @override
  String get addNewGuest => 'Add New Guest';

  @override
  String get signupFailed => 'Signup failed';

  @override
  String get resetPasswordLinkSent =>
      'A reset password link has been sent to your email address. You can update your password from there.';

  @override
  String get noPollsYet => 'No polls yet';

  @override
  String get noEventsYet => 'No events yet';

  @override
  String get noPaymentRequestsFound => 'No payment requests found';

  @override
  String get receiptSubmittedToAdmin =>
      'Your receipt has been submitted to the admin';

  @override
  String accessTitleLabel(String title) {
    return '$title Access';
  }

  @override
  String get photos => 'Photos';

  @override
  String get visitorType => 'Visitor Type';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get vehicleNameHint => 'e.g. ALTO';

  @override
  String get colorHint => 'e.g. Black';

  @override
  String get licenseNumberHint => 'License Number';

  @override
  String get receiptUnavailable => 'Receipt unavailable';

  @override
  String get select => 'Select';

  @override
  String get informationUnavailable => 'Information unavailable';

  @override
  String get contact => 'Contact';

  @override
  String get guardInfoUnavailable => 'Guard information is unavailable';

  @override
  String get selectDateForAccessRequest =>
      'Select a date for the access request';

  @override
  String get selectTimeForAccessRequest =>
      'Select a time for the access request';

  @override
  String get selectAccessForRequest => 'Select access for the request';

  @override
  String get pleaseUploadReceipt => 'Please upload a receipt before submitting';

  @override
  String get visitorDeletedSuccessfully => 'Visitor deleted successfully';

  @override
  String get failedToDeleteVisitor =>
      'Failed to delete visitor. Please try again.';

  @override
  String get loginFailed => 'Login failed. Please try again.';

  @override
  String get pleaseEnterVehicleName => 'Please enter vehicle name';

  @override
  String get pleaseEnterVehicleColor => 'Please enter vehicle color';

  @override
  String get pleaseEnterLicensePlate =>
      'Please enter vehicle license plate number';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Please enter vehicle registration number';

  @override
  String get nameCannotBeEmpty =>
      'Name cannot be empty. Please enter your name';

  @override
  String get portalixAccessQr => 'Portalix access QR';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get pleaseEnterValidEmail => 'Please enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get fullNameRequired => 'Full name is required';

  @override
  String get fullNameMinLength => 'Full name must be at least 2 characters';

  @override
  String get appointmentDateRequired => 'Appointment date is required';

  @override
  String get dayMustBeBetween => 'Day must be between 1 and 31';

  @override
  String get pleaseUploadProfilePicture => 'Please upload your profile picture';

  @override
  String get userNotFound => 'User not found';

  @override
  String get userNotFoundLoginAgain => 'User not found. Please log in again';

  @override
  String get accountMustBeApprovedForQr =>
      'Account must be approved before generating access QR';

  @override
  String get inProgress => 'In Progress';

  @override
  String get resolved => 'Resolved';

  @override
  String get rejected => 'Rejected';

  @override
  String get authInvalidEmail => 'The email address is not valid.';

  @override
  String get authUserDisabled => 'This user account has been disabled.';

  @override
  String get authUserNotFound => 'No user found for that email.';

  @override
  String get authWrongPassword => 'Wrong password provided for that user.';

  @override
  String get authEmailAlreadyInUse =>
      'The email address is already in use by another account.';

  @override
  String get authOperationNotAllowed =>
      'Email/password accounts are not enabled.';

  @override
  String get authWeakPassword => 'The password provided is too weak.';

  @override
  String get authInvalidCredential =>
      'The provided email or password is invalid.';

  @override
  String get authUnknownError => 'An unknown error occurred.';

  @override
  String get zkbioAccessFailed => 'Door access failed';
}
