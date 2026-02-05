import 'package:flutter/material.dart';
import 'package:portalixmx_app/models/access_control_api_response.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/primary_btn.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class AccessSummaryPage extends StatelessWidget{
  const AccessSummaryPage({super.key, required this.access});
  final AccessRequestModel access;
  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(child: Column(
      spacing: 20,
      children: [
        Padding(padding: EdgeInsets.only(top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text('${access.name} Access', style: AppTextStyles.regularTextStyle,),
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
                padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                child: Column(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: VisitorInfoItemWidget(
                            title: 'Date', subTitle: DateTimeFormatHelpers.formatDateTime(access.access.first.timeStamp),showDivider: true,),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(
                              title: 'Time', subTitle: DateTimeFormatHelpers.formatDateTime(access.access.first.timeStamp),showDivider: true,)
                        ),
                      ],
                    ),
                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: VisitorInfoItemWidget(
                            title: 'Requested Time', subTitle: 'Sep 20, 2024',),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(
                              title: 'Access Approved Date', subTitle: '10:00AM - 06:00PM',)
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Text("QR CODE", style: AppTextStyles.visitorDetailTitleTextStyle,),
                    Image.asset(AppIcons.icQRCode),
                    const Spacer(),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 40),
                      width: double.infinity,
                      child: PrimaryBtn(
                        onTap: () {}, btnText: "Share Key", color: AppColors.primaryColor,),
                    )
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }

}