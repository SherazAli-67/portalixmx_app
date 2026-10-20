import '../../l10n/app_localizations.dart';

class AuthErrorLocalizer {
  static String localize(AppLocalizations l10n, String error) {
    final code = error.replaceFirst('Exception: ', '').trim();
    switch (code) {
      case 'invalid-email':
        return l10n.authInvalidEmail;
      case 'user-disabled':
        return l10n.authUserDisabled;
      case 'user-not-found':
        return l10n.authUserNotFound;
      case 'wrong-password':
        return l10n.authWrongPassword;
      case 'email-already-in-use':
        return l10n.authEmailAlreadyInUse;
      case 'operation-not-allowed':
        return l10n.authOperationNotAllowed;
      case 'weak-password':
        return l10n.authWeakPassword;
      case 'invalid-credential':
        return l10n.authInvalidCredential;
      case 'please_upload_profile_picture':
        return l10n.pleaseUploadProfilePicture;
      case 'user_not_found':
        return l10n.userNotFound;
      case 'user_not_found_login_again':
        return l10n.userNotFoundLoginAgain;
      case 'failed_to_load_societies':
        return l10n.failedToLoadSocieties;
      case 'zkbio_access_failed':
        return l10n.zkbioAccessFailed;
      case 'emergency_alert_failed':
        return l10n.emergencyAlertFailed;
      case 'unknown':
        return l10n.authUnknownError;
      default:
        if (code.isEmpty) return l10n.authUnknownError;
        return code;
    }
  }
}
