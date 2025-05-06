import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_polls_detail_page.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_constants.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';
import '../../../res/app_textstyles.dart';
import '../vistors/widgets/vistor_info_item_widget.dart';

class CommunityPollsPage extends StatelessWidget{
  const CommunityPollsPage({super.key});

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
              Text("Community Polls", style: AppTextStyles.regularTextStyle,),
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
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (ctx, index){
                  return GestureDetector(
                    onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> CommunityPollsDetailPage())),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: AppColors.btnColor,
                                child: Center(child: Icon(Icons.person, color: Colors.white,),)
                            ),
                            const SizedBox(width: 10,),
                            Text("Admin", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.postGreyColor),),
                            const Spacer(),
                            Text("2 hrs ago")
                          ],
                        ),
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
                        Text(AppConstants.dummyEventDescription2Lines, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff666666)),),
                        Divider()
                      ],
                    ),
                  );
                })
            ),
          ),
        )
      ],
    ),);
  }

}