import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/status_display_helper.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/services/access_requests_service/access_request_service.dart';
import '../../../../core/models/access_request_model.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class AccessSummaryPage extends StatelessWidget{
  const AccessSummaryPage({super.key, required this.access});
  final AccessRequestModel access;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: const EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackButton(color: Colors.white,),
              Expanded(child: Text(localization.accessTitleLabel(access.requestedAccessTitle), style: AppTextStyles.regularTextStyle, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,)),
              const SizedBox(width: 20)
            ],
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: StreamBuilder<AccessRequestModel?>(
              stream: AccessRequestService.instance.watchRequestById(access.id),
              initialData: access,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && snapshot.data == null) {
                  return const LoadingWidget();
                }
                final current = snapshot.data ?? access;
                final approvedDate = current.zkAccessGrantedAt != null
                    ? DateTimeFormatHelpers.formatDateTime(current.zkAccessGrantedAt!)
                    : '—';
                return Padding(
                    padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18, bottom: 24),
                    child: Column(
                      spacing: 15,
                      children: [
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: VisitorInfoItemWidget(
                                title: localization.date, subTitle: DateTimeFormatHelpers.formatDateTime(current.createdAt),showDivider: true,),
                            ),
                            Expanded(
                                child: VisitorInfoItemWidget(
                                  title: localization.time, subTitle: DateTimeFormatHelpers.formatTime(current.requestedForTime),showDivider: true,)
                            ),
                          ],
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            Expanded(
                              child: VisitorInfoItemWidget(
                                title: localization.requestedTime, subTitle: DateTimeFormatHelpers.formatDateTime(current.requestedForDate),),
                            ),
                            Expanded(
                                child: VisitorInfoItemWidget(
                                  title: localization.accessApprovedDate, subTitle: approvedDate,)
                            ),
                          ],
                        ),
                        VisitorInfoItemWidget(
                          title: localization.status,
                          subTitle: StatusDisplayHelper.label(current.status, localization),
                          showDivider: true,
                        ),
                      ],
                    )
                );
              }
            ),
          ),
        )
      ],
    ),);
  }
}
