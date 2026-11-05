import '../../l10n/app_localizations.dart';

class Validators {
  static String? Function(String?) validateEmail(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.emailRequired;
      }
      if (!RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[\w\-]{2,}$').hasMatch(value.trim())) {
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
      if (value.length < 8) {
        return l10n.passwordMinLength;
      }
      return null;
    };
  }

  static String? Function(String?) validateFullName(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.fullNameRequired;
      }
      if (value.trim().length < 2) {
        return l10n.fullNameMinLength;
      }
      return null;
    };
  }

  static String? Function(String?) validatePhone(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.phoneRequired;
      }
      final digits = value.trim().replaceAll(RegExp(r'\D'), '');
      if (digits.length != 10) {
        return l10n.phoneMustBe10Digits;
      }
      return null;
    };
  }

  static String? Function(String?) validateLicensePlate(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.pleaseEnterLicensePlate;
      }
      final plate = value.trim();
      if (plate.length < 3) {
        return l10n.plateMinLength;
      }
      if (!RegExp(r'^[A-Za-z0-9\-]+$').hasMatch(plate)) {
        return l10n.pleaseEnterValidPlate;
      }
      return null;
    };
  }

  static String? Function(String?) validateRequired(AppLocalizations l10n, String message) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
  }

  static String? Function(String?) validateMinLength(
    AppLocalizations l10n, {
    required String emptyMessage,
    required String minLengthMessage,
    int minLength = 2,
  }) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return emptyMessage;
      }
      if (value.trim().length < minLength) {
        return minLengthMessage;
      }
      return null;
    };
  }

  static String? Function(String?) validateHouseNumber(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.houseNumberRequired;
      }
      return null;
    };
  }

  static String? Function(String?) validateAddress(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.addressRequired;
      }
      if (value.trim().length < 3) {
        return l10n.addressMinLength;
      }
      return null;
    };
  }

  static String? Function(String?) validateComplaint(AppLocalizations l10n) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return l10n.complaintRequired;
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
