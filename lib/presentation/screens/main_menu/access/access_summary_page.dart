import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/helpers/status_display_helper.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import '../../../../core/models/access_request_model.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class AccessSummaryPage extends StatelessWidget{
  const AccessSummaryPage({super.key, required this.access});
  final AccessRequestModel access;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final approvedDate = access.zkAccessGrantedAt != null
        ? DateTimeFormatHelpers.formatDateTime(access.zkAccessGrantedAt!)
        : '—';
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text(localization.accessTitleLabel(access.requestedAccessTitle), style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 20)
            ],
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18, bottom: 24),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: VisitorInfoItemWidget(
                            title: localization.date, subTitle: DateTimeFormatHelpers.formatDateTime(access.createdAt),showDivider: true,),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(
                              title: localization.time, subTitle: DateTimeFormatHelpers.formatTime(access.requestedForTime),showDivider: true,)
                        ),
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: VisitorInfoItemWidget(
                            title: localization.requestedTime, subTitle: DateTimeFormatHelpers.formatDateTime(access.requestedForDate),),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(
                              title: localization.accessApprovedDate, subTitle: approvedDate,)
                        ),
                      ],
                    ),
                    VisitorInfoItemWidget(
                      title: localization.status,
                      subTitle: StatusDisplayHelper.label(access.status, localization),
                      showDivider: true,
                    ),
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }
}
