import '../../l10n/app_localizations.dart';

class Validators {
  static String? Function(String?) validateEmail(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return l10n.emailRequired;
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return l10n.pleaseEnterValidEmail;
      }
      return null;
    };
  }

  static String? Function(String?) validatePassword(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return l10n.passwordRequired;
      }
      return null;
    };
  }

  static String? Function(String?) validateFullName(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return l10n.fullNameRequired;
      }
      if (value.trim().length < 2) {
        return l10n.fullNameMinLength;
      }
      return null;
    };
  }

  static String? Function(String?) validateAppointmentDate(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.appointmentDateRequired;
      }
      final trimmed = value.trim();
      final parts = trimmed.split(',');
      final dateParts = parts.first.split(' ');
      final day = int.tryParse(dateParts[0]);

      if (day == null || day < 1 || day > 31) {
        return l10n.dayMustBeBetween;
      }
      return null;
    };
  }
}
