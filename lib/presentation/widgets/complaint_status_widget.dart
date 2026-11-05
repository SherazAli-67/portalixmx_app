import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/status_display_helper.dart';
import 'package:portalixmx_app/core/models/complaints_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';

class ComplaintStatusWidget extends StatelessWidget {
  const ComplaintStatusWidget({
    super.key,
    required this.status
  });
  final ComplaintStatus status;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(99),
        color: getColorByStatus(status).withValues(alpha: 0.12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
       StatusDisplayHelper.label(status, l10n),
        style: AppTextStyles.tileSubtitleTextStyle.copyWith(color: getColorByStatus(status), fontWeight: FontWeight.w600),
      ),
    );
  }

  Color getColorByStatus(ComplaintStatus status) {
    switch(status){
      case ComplaintStatus.pending:
        return AppColors.statusPending;
      case ComplaintStatus.rejected:
        return AppColors.statusError;
      case ComplaintStatus.resolved:
        return AppColors.statusSuccess;
      case ComplaintStatus.inProgress:
        return AppColors.statusSubmitted;
    }
  }
}
