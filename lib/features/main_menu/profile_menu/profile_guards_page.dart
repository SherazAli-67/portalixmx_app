import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/guard_tracking_map_page.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';

class ProfileGuardsPage extends StatelessWidget{
  const ProfileGuardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
      child: Column(
        spacing: 20,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 65.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white),
                Text("Guard Tracking", style: AppTextStyles.regularTextStyle),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Card(
              color: AppColors.lightGreyBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Material(
                            color: AppColors.lightGreyBackgroundColor,
                            child: ListTile(
                              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> GuardTrackingMapPage())),
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.btnColor,
                                child: Center(child: Icon(Icons.person, color: Colors.white,),),
                              ),
                              tileColor: Colors.white,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Muhammad Ali", style: AppTextStyles.tileTitleTextStyle,),
                                  Text("+92 307 2215500", style: AppTextStyles.tileSubtitleTextStyle,)
                                ],
                              ),
                              trailing: IconButton(onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (_)=> GuardTrackingMapPage()));
                              }, icon: Icon(Icons.my_location, color: AppColors.primaryColor,)),
                            ),
                          ),
                        );
                      })
              ),
            ),
          ),
        ],
      ),
    );
  }

}