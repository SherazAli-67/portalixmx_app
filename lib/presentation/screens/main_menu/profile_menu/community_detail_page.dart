import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_constants.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class CommunityDetailPage extends StatelessWidget{
  const CommunityDetailPage({super.key});

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
              Text("Event Name", style: AppTextStyles.regularTextStyle,),
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
                  spacing: 15,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl: AppIcons.icComplaintImageUrl)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Event Name", style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: AppColors.darkGreyColor),),
                        Text("Sep 20, 10:00 AM", style: AppTextStyles.emergencyContactTitleTextStyle,),
                      ],
                    ),
                    Text(AppConstants.dummyEventDescription, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff666666)),)
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }

}