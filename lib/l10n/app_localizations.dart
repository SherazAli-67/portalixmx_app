import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Portalixmx'**
  String get appTitle;

  /// No description provided for @residentLogin.
  ///
  /// In en, this message translates to:
  /// **'Resident Login'**
  String get residentLogin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget your password'**
  String get forgetPassword;

  /// No description provided for @selectSociety.
  ///
  /// In en, this message translates to:
  /// **'Select Society'**
  String get selectSociety;

  /// No description provided for @failedToLoadSocieties.
  ///
  /// In en, this message translates to:
  /// **'Unable to load societies. Please try again.'**
  String get failedToLoadSocieties;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @accountRequestPending.
  ///
  /// In en, this message translates to:
  /// **'Your resident request for {societyName} is pending. You will be notified as the admin update your request'**
  String accountRequestPending(String societyName);

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcomeMessage(Object name);

  /// No description provided for @regularVisitors.
  ///
  /// In en, this message translates to:
  /// **'Regular Visitors'**
  String get regularVisitors;

  /// No description provided for @guest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get guest;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @paymentFor.
  ///
  /// In en, this message translates to:
  /// **'Payment for'**
  String get paymentFor;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @receipt.
  ///
  /// In en, this message translates to:
  /// **'Payment Receipt'**
  String get receipt;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @paymentDetail.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetail;

  /// No description provided for @accessRequests.
  ///
  /// In en, this message translates to:
  /// **'Access Requests'**
  String get accessRequests;

  /// No description provided for @poolAccess.
  ///
  /// In en, this message translates to:
  /// **'Pool Access'**
  String get poolAccess;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @twoStepVerification.
  ///
  /// In en, this message translates to:
  /// **'2 Step Verification'**
  String get twoStepVerification;

  /// No description provided for @twoStepVerificationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter the 2 step verification code sent on your email address'**
  String get twoStepVerificationDescription;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help'**
  String get needHelp;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @access.
  ///
  /// In en, this message translates to:
  /// **'Access'**
  String get access;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @regularVisitor.
  ///
  /// In en, this message translates to:
  /// **'Regular Visitor'**
  String get regularVisitor;

  /// No description provided for @requestedTime.
  ///
  /// In en, this message translates to:
  /// **'REQUESTED TIME'**
  String get requestedTime;

  /// No description provided for @accessFor.
  ///
  /// In en, this message translates to:
  /// **'Access For'**
  String get accessFor;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @accessApprovedDate.
  ///
  /// In en, this message translates to:
  /// **'Access Approved Date'**
  String get accessApprovedDate;

  /// No description provided for @contactNum.
  ///
  /// In en, this message translates to:
  /// **'Contact No'**
  String get contactNum;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @shareKey.
  ///
  /// In en, this message translates to:
  /// **'Share Key'**
  String get shareKey;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR CODE'**
  String get qrCode;

  /// No description provided for @paymentsAndBilling.
  ///
  /// In en, this message translates to:
  /// **'Payments & Billing'**
  String get paymentsAndBilling;

  /// No description provided for @currentService.
  ///
  /// In en, this message translates to:
  /// **'Current Service'**
  String get currentService;

  /// No description provided for @otherServices.
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get otherServices;

  /// No description provided for @serviceName.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceName;

  /// No description provided for @cleaningOfCommonAreas.
  ///
  /// In en, this message translates to:
  /// **'Cleaning of common areas'**
  String get cleaningOfCommonAreas;

  /// No description provided for @garbageCollection.
  ///
  /// In en, this message translates to:
  /// **'Garbage Collection'**
  String get garbageCollection;

  /// No description provided for @complaint.
  ///
  /// In en, this message translates to:
  /// **'Complaint'**
  String get complaint;

  /// No description provided for @uploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'Upload Photos'**
  String get uploadPhotos;

  /// No description provided for @openCamera.
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get openCamera;

  /// No description provided for @requestAccess.
  ///
  /// In en, this message translates to:
  /// **'Request Access'**
  String get requestAccess;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View Profile'**
  String get viewProfile;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @communityCalendar.
  ///
  /// In en, this message translates to:
  /// **'Community Calendar'**
  String get communityCalendar;

  /// No description provided for @communityPolls.
  ///
  /// In en, this message translates to:
  /// **'Community Polls'**
  String get communityPolls;

  /// No description provided for @pollEndsAt.
  ///
  /// In en, this message translates to:
  /// **'Ends {when}'**
  String pollEndsAt(String when);

  /// No description provided for @pollVote.
  ///
  /// In en, this message translates to:
  /// **'Vote'**
  String get pollVote;

  /// No description provided for @pollAlreadyVoted.
  ///
  /// In en, this message translates to:
  /// **'You have already voted'**
  String get pollAlreadyVoted;

  /// No description provided for @pollEnded.
  ///
  /// In en, this message translates to:
  /// **'This poll has ended'**
  String get pollEnded;

  /// No description provided for @pollVoteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not submit vote'**
  String get pollVoteFailed;

  /// No description provided for @pollSelectOption.
  ///
  /// In en, this message translates to:
  /// **'Please select an option'**
  String get pollSelectOption;

  /// No description provided for @guards.
  ///
  /// In en, this message translates to:
  /// **'Guards'**
  String get guards;

  /// No description provided for @carPooling.
  ///
  /// In en, this message translates to:
  /// **'Car Pooling'**
  String get carPooling;

  /// No description provided for @emergencyCalls.
  ///
  /// In en, this message translates to:
  /// **'Emergency Calls'**
  String get emergencyCalls;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @guardTracking.
  ///
  /// In en, this message translates to:
  /// **'Guard Tracking'**
  String get guardTracking;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @vehicleInformation.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Information'**
  String get vehicleInformation;

  /// No description provided for @vehicleName.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Name'**
  String get vehicleName;

  /// No description provided for @licensePlateNumber.
  ///
  /// In en, this message translates to:
  /// **'License Plate Number'**
  String get licensePlateNumber;

  /// No description provided for @registrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration Number'**
  String get registrationNumber;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @updateYour.
  ///
  /// In en, this message translates to:
  /// **'Update your {userInfo}'**
  String updateYour(Object userInfo);

  /// No description provided for @addGuest.
  ///
  /// In en, this message translates to:
  /// **'Add Guest'**
  String get addGuest;

  /// No description provided for @deleteComplaint.
  ///
  /// In en, this message translates to:
  /// **'Delete Complaint'**
  String get deleteComplaint;

  /// No description provided for @profileInfoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile information updated'**
  String get profileInfoUpdated;

  /// No description provided for @profileInfoUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile updating failed, Please try again'**
  String get profileInfoUpdateFailed;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @deleteVisitor.
  ///
  /// In en, this message translates to:
  /// **'Delete Visitor'**
  String get deleteVisitor;

  /// No description provided for @deleteGuest.
  ///
  /// In en, this message translates to:
  /// **'Delete Guest'**
  String get deleteGuest;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @editGuest.
  ///
  /// In en, this message translates to:
  /// **'Edit Guest'**
  String get editGuest;

  /// No description provided for @carPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Car Plate Number'**
  String get carPlateNumber;

  /// No description provided for @vehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Model'**
  String get vehicleModel;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @dateFrom.
  ///
  /// In en, this message translates to:
  /// **'Date From'**
  String get dateFrom;

  /// No description provided for @dateTo.
  ///
  /// In en, this message translates to:
  /// **'Date To'**
  String get dateTo;

  /// No description provided for @hasBeenEditedMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} has been updated'**
  String hasBeenEditedMessage(Object name);

  /// No description provided for @hasBeenAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'{name} has been added as a {guestType}'**
  String hasBeenAddedMessage(Object guestType, Object name);

  /// No description provided for @accessRequestPending.
  ///
  /// In en, this message translates to:
  /// **'The request for {accessTitle} is already in pending state'**
  String accessRequestPending(Object accessTitle);

  /// No description provided for @accessRequestSubmitted.
  ///
  /// In en, this message translates to:
  /// **'The request for {accessTitle} is submitted to Portalix Admin'**
  String accessRequestSubmitted(Object accessTitle);

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @createAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Create account with Portalixmx and get started with the society management'**
  String get createAccountDescription;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @completeProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Please provide the rest information to complete your profile'**
  String get completeProfileDescription;

  /// No description provided for @additionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetails;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterContactNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter contact number'**
  String get pleaseEnterContactNumber;

  /// No description provided for @pleaseEnterCarPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter car plate number'**
  String get pleaseEnterCarPlateNumber;

  /// No description provided for @pleaseEnterVehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle model'**
  String get pleaseEnterVehicleModel;

  /// No description provided for @pleaseEnterColor.
  ///
  /// In en, this message translates to:
  /// **'Please enter color'**
  String get pleaseEnterColor;

  /// No description provided for @pleaseSelectFromDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select from date and time'**
  String get pleaseSelectFromDateTime;

  /// No description provided for @pleaseSelectToDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select to date and time'**
  String get pleaseSelectToDateTime;

  /// No description provided for @toDateTimeMustBeAfterFromDateTime.
  ///
  /// In en, this message translates to:
  /// **'To date/time must be after from date/time'**
  String get toDateTimeMustBeAfterFromDateTime;

  /// No description provided for @pleaseSelectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one day with time'**
  String get pleaseSelectAtLeastOneDay;

  /// No description provided for @visitorAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Visitor added successfully'**
  String get visitorAddedSuccessfully;

  /// No description provided for @visitorUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Visitor updated successfully'**
  String get visitorUpdatedSuccessfully;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @automaticVisitorCode.
  ///
  /// In en, this message translates to:
  /// **'Visitor Code'**
  String get automaticVisitorCode;

  /// No description provided for @generateAccessCode.
  ///
  /// In en, this message translates to:
  /// **'Generate Access Code'**
  String get generateAccessCode;

  /// No description provided for @myAccessQr.
  ///
  /// In en, this message translates to:
  /// **'My Access QR'**
  String get myAccessQr;

  /// No description provided for @myAccessQrDescription.
  ///
  /// In en, this message translates to:
  /// **'Show this QR code at the door reader to enter the community.'**
  String get myAccessQrDescription;

  /// No description provided for @refreshQr.
  ///
  /// In en, this message translates to:
  /// **'Refresh QR'**
  String get refreshQr;

  /// No description provided for @shareQrCode.
  ///
  /// In en, this message translates to:
  /// **'Share QR Code'**
  String get shareQrCode;

  /// No description provided for @zkbioNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Door access is not configured for your society yet.'**
  String get zkbioNotConfigured;

  /// No description provided for @accountNotApprovedForQr.
  ///
  /// In en, this message translates to:
  /// **'Your account must be approved by the society admin before you can use access QR.'**
  String get accountNotApprovedForQr;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @guestAccessQr.
  ///
  /// In en, this message translates to:
  /// **'Guest Access QR'**
  String get guestAccessQr;

  /// No description provided for @guestQrShowAtDoor.
  ///
  /// In en, this message translates to:
  /// **'Show this QR at the door reader during the visit window.'**
  String get guestQrShowAtDoor;

  /// No description provided for @guestQrUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to load guest access QR.'**
  String get guestQrUnavailable;

  /// No description provided for @guestVisitEnded.
  ///
  /// In en, this message translates to:
  /// **'This guest visit has ended.'**
  String get guestVisitEnded;

  /// No description provided for @guestQrOutsideWindow.
  ///
  /// In en, this message translates to:
  /// **'Guest QR is only available during the scheduled visit window.'**
  String get guestQrOutsideWindow;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @fundManagement.
  ///
  /// In en, this message translates to:
  /// **'Fund Management'**
  String get fundManagement;

  /// No description provided for @createFundReport.
  ///
  /// In en, this message translates to:
  /// **'Create Fund Report'**
  String get createFundReport;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Title'**
  String get reportTitle;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @expenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Expense Label'**
  String get expenseLabel;

  /// No description provided for @addExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @publishReport.
  ///
  /// In en, this message translates to:
  /// **'Publish Report'**
  String get publishReport;

  /// No description provided for @saveAsDraft.
  ///
  /// In en, this message translates to:
  /// **'Save as Draft'**
  String get saveAsDraft;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @emptyFundReportsMsg.
  ///
  /// In en, this message translates to:
  /// **'No fund reports yet'**
  String get emptyFundReportsMsg;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// No description provided for @noExpenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses listed'**
  String get noExpenses;

  /// No description provided for @emergencyCall.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY CALL'**
  String get emergencyCall;

  /// No description provided for @removeContact.
  ///
  /// In en, this message translates to:
  /// **'Remove Contact'**
  String get removeContact;

  /// No description provided for @selectEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Select Emergency Contacts'**
  String get selectEmergencyContacts;

  /// No description provided for @saveContacts.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveContacts;

  /// No description provided for @emergencyAlertSent.
  ///
  /// In en, this message translates to:
  /// **'Emergency notification sent'**
  String get emergencyAlertSent;

  /// No description provided for @emergencyAlertFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to send emergency alert'**
  String get emergencyAlertFailed;

  /// No description provided for @addEmergencyContactsFirst.
  ///
  /// In en, this message translates to:
  /// **'Add emergency contacts first'**
  String get addEmergencyContactsFirst;

  /// No description provided for @noResidentsFound.
  ///
  /// In en, this message translates to:
  /// **'No residents found'**
  String get noResidentsFound;

  /// No description provided for @noEmergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'No emergency contacts'**
  String get noEmergencyContacts;

  /// No description provided for @holdToSendEmergency.
  ///
  /// In en, this message translates to:
  /// **'Hold for 3 seconds to send'**
  String get holdToSendEmergency;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @society.
  ///
  /// In en, this message translates to:
  /// **'Society'**
  String get society;

  /// No description provided for @accountStillPending.
  ///
  /// In en, this message translates to:
  /// **'Your account is still pending approval'**
  String get accountStillPending;

  /// No description provided for @unableToRefreshStatus.
  ///
  /// In en, this message translates to:
  /// **'Unable to refresh status. Please try again.'**
  String get unableToRefreshStatus;

  /// No description provided for @guestsDirectory.
  ///
  /// In en, this message translates to:
  /// **'Guests Directory'**
  String get guestsDirectory;

  /// No description provided for @noVisitorFound.
  ///
  /// In en, this message translates to:
  /// **'No visitor found'**
  String get noVisitorFound;

  /// No description provided for @addNewGuest.
  ///
  /// In en, this message translates to:
  /// **'Add New Guest'**
  String get addNewGuest;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signupFailed;

  /// No description provided for @resetPasswordLinkSent.
  ///
  /// In en, this message translates to:
  /// **'A reset password link has been sent to your email address. You can update your password from there.'**
  String get resetPasswordLinkSent;

  /// No description provided for @noPollsYet.
  ///
  /// In en, this message translates to:
  /// **'No polls yet'**
  String get noPollsYet;

  /// No description provided for @noEventsYet.
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get noEventsYet;

  /// No description provided for @noPaymentRequestsFound.
  ///
  /// In en, this message translates to:
  /// **'No payment requests found'**
  String get noPaymentRequestsFound;

  /// No description provided for @receiptSubmittedToAdmin.
  ///
  /// In en, this message translates to:
  /// **'Your receipt has been submitted to the admin'**
  String get receiptSubmittedToAdmin;

  /// No description provided for @accessTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'{title} Access'**
  String accessTitleLabel(String title);

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @visitorType.
  ///
  /// In en, this message translates to:
  /// **'Visitor Type'**
  String get visitorType;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @vehicleNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. ALTO'**
  String get vehicleNameHint;

  /// No description provided for @colorHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Black'**
  String get colorHint;

  /// No description provided for @licenseNumberHint.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumberHint;

  /// No description provided for @receiptUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Receipt unavailable'**
  String get receiptUnavailable;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @informationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Information unavailable'**
  String get informationUnavailable;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @guardInfoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Guard information is unavailable'**
  String get guardInfoUnavailable;

  /// No description provided for @selectDateForAccessRequest.
  ///
  /// In en, this message translates to:
  /// **'Select a date for the access request'**
  String get selectDateForAccessRequest;

  /// No description provided for @selectTimeForAccessRequest.
  ///
  /// In en, this message translates to:
  /// **'Select a time for the access request'**
  String get selectTimeForAccessRequest;

  /// No description provided for @selectAccessForRequest.
  ///
  /// In en, this message translates to:
  /// **'Select access for the request'**
  String get selectAccessForRequest;

  /// No description provided for @pleaseUploadReceipt.
  ///
  /// In en, this message translates to:
  /// **'Please upload a receipt before submitting'**
  String get pleaseUploadReceipt;

  /// No description provided for @visitorDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Visitor deleted successfully'**
  String get visitorDeletedSuccessfully;

  /// No description provided for @failedToDeleteVisitor.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete visitor. Please try again.'**
  String get failedToDeleteVisitor;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailed;

  /// No description provided for @pleaseEnterVehicleName.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle name'**
  String get pleaseEnterVehicleName;

  /// No description provided for @pleaseEnterVehicleColor.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle color'**
  String get pleaseEnterVehicleColor;

  /// No description provided for @pleaseEnterLicensePlate.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle license plate number'**
  String get pleaseEnterLicensePlate;

  /// No description provided for @pleaseEnterRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter vehicle registration number'**
  String get pleaseEnterRegistrationNumber;

  /// No description provided for @nameCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name cannot be empty. Please enter your name'**
  String get nameCannotBeEmpty;

  /// No description provided for @portalixAccessQr.
  ///
  /// In en, this message translates to:
  /// **'Portalix access QR'**
  String get portalixAccessQr;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get pleaseEnterValidEmail;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get fullNameRequired;

  /// No description provided for @fullNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Full name must be at least 2 characters'**
  String get fullNameMinLength;

  /// No description provided for @appointmentDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Appointment date is required'**
  String get appointmentDateRequired;

  /// No description provided for @dayMustBeBetween.
  ///
  /// In en, this message translates to:
  /// **'Day must be between 1 and 31'**
  String get dayMustBeBetween;

  /// No description provided for @pleaseUploadProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Please upload your profile picture'**
  String get pleaseUploadProfilePicture;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get userNotFound;

  /// No description provided for @userNotFoundLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please log in again'**
  String get userNotFoundLoginAgain;

  /// No description provided for @accountMustBeApprovedForQr.
  ///
  /// In en, this message translates to:
  /// **'Account must be approved before generating access QR'**
  String get accountMustBeApprovedForQr;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is not valid.'**
  String get authInvalidEmail;

  /// No description provided for @authUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This user account has been disabled.'**
  String get authUserDisabled;

  /// No description provided for @authUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get authUserNotFound;

  /// No description provided for @authWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password provided for that user.'**
  String get authWrongPassword;

  /// No description provided for @authEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'The email address is already in use by another account.'**
  String get authEmailAlreadyInUse;

  /// No description provided for @authOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Email/password accounts are not enabled.'**
  String get authOperationNotAllowed;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password provided is too weak.'**
  String get authWeakPassword;

  /// No description provided for @authInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'The provided email or password is invalid.'**
  String get authInvalidCredential;

  /// No description provided for @authUnknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get authUnknownError;

  /// No description provided for @zkbioAccessFailed.
  ///
  /// In en, this message translates to:
  /// **'Door access failed'**
  String get zkbioAccessFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
