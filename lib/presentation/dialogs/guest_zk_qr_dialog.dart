import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/res/app_textstyles.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/zkbio_qr_widget.dart';
import 'package:portalixmx_app/services/zkbio_access_service/zkbio_access_service.dart';

class GuestZkQrDialog extends StatelessWidget {
  const GuestZkQrDialog({
    super.key,
    required this.guestName,
    required this.qrPayload,
    required this.visitorId,
  });

  final String guestName;
  final String qrPayload;
  final String visitorId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final zkbioService = ZkbioAccessService.instance;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              l10n.guestAccessQr,
              style: AppTextStyles.regularTextStyle.copyWith(color: Colors.black),
            ),
          ),
          Text(
            guestName,
            style: AppTextStyles.headingTextStyle.copyWith(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          Text(
            l10n.guestQrShowAtDoor,
            textAlign: TextAlign.center,
            style: AppTextStyles.subHeadingTextStyle.copyWith(
              color: Colors.black54,
              fontSize: 13,
            ),
          ),
          ZkbioQrWidget(
            qrPayload: qrPayload,
            shareLabel: '${l10n.guestAccessQr} - $guestName',
            onRefresh: () async {
              final refreshed = await zkbioService.refreshGuestQr(visitorId);
              return refreshed.qrPayload;
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.close,
                style: AppTextStyles.regularTextStyle.copyWith(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
