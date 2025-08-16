import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';
import '../../../res/app_textstyles.dart';

class CommunityPollsDetailPage extends StatelessWidget{
  const CommunityPollsDetailPage({super.key});

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

        ExpandableCarousel(
          options: ExpandableCarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            viewportFraction: 0.9,

          ),
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      spacing: 20,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Admin", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkGreyColor2),),
                            Text("Ends in 2hrs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.darkGreyColor2),),

                          ],
                        ),
                        Text('Enter the 2 Verification code lorem ipsum dolor sit amet, consectetur adipiscing elit?', maxLines: 2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
                        Column(
                          spacing: 8,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                border: Border.all(color: AppColors.primaryColor),
                                color: Color(0xffEFEEFF)
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text("Yes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.primaryColor),),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(color: AppColors.greyColor2),
                              ),
                              padding: EdgeInsets.all(15),
                              child: Text("No", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,),
                            ),)

                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        )
      ],
    ),);
  }

}