import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';

import '../../../res/app_textstyles.dart';
import '../vistors/widgets/vistor_info_item_widget.dart';

class ComplaintSummaryPage extends StatelessWidget{
  const ComplaintSummaryPage({super.key});

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
              Text("Complaint ABC", style: AppTextStyles.regularTextStyle,),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: VisitorInfoItemWidget(
                          title: 'Date', subTitle: 'Sep 20, 2024',),
                      ),
                      Expanded(
                          child: VisitorInfoItemWidget(
                            title: 'Status', subTitle: 'Approved',)
                      ),
                    ],
                  ),
                  Divider(),
                  VisitorInfoItemWidget(title: 'Complaint', subTitle: 'Enter the 2-step verification code sent on the given number', showDivider: true),
                  Text("Photos", style: AppTextStyles.visitorDetailTitleTextStyle,),
                  Expanded(child: GridView.builder(
                      itemCount: 5,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,   mainAxisSpacing: 10, crossAxisSpacing: 10), itemBuilder: (ctx, index){
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(imageUrl: AppIcons.icComplaintImageUrl, height: 75, fit: BoxFit.cover,),
                    );
                  }))
                ],
              )
            ),
          ),
        )
      ],
    ),);
  }

}