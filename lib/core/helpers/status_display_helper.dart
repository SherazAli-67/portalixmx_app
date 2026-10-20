import '../../l10n/app_localizations.dart';

class StatusDisplayHelper {
  static String label(Enum status, AppLocalizations l10n) {
    switch (status.name) {
      case 'pending':
        return l10n.pending;
      case 'approved':
        return l10n.approved;
      case 'submitted':
        return l10n.submitted;
      case 'received':
        return l10n.received;
      case 'inProgress':
        return l10n.inProgress;
      case 'resolved':
        return l10n.resolved;
      case 'rejected':
        return l10n.rejected;
      case 'draft':
        return l10n.draft;
      case 'published':
        return l10n.published;
      default:
        final spaced = status.name.replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match[1]} ${match[2]}',
        );
        return spaced
            .split(' ')
            .map((word) => word.isEmpty
                ? word
                : '${word[0].toUpperCase()}${word.substring(1)}')
            .join(' ');
    }
  }
}
