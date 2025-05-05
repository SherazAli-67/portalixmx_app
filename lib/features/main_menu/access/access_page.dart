import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/features/main_menu/access/request_access_page.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_icons.dart';

import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class AccessMenu extends StatelessWidget{
  const AccessMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            spacing: 10,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40,),
                  Text("Access Requests", style: AppTextStyles.regularTextStyle,),
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.btnColor
                      ),
                      onPressed: ()=> _onRequestAccessTap(context), icon: Icon(Icons.add, color: Colors.white,)),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (ctx, index){
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 15),
                            leading: SvgPicture.asset(AppIcons.icGame, colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                            title: Text("Pool Access", style: AppTextStyles.tileTitleTextStyle),
                            subtitle: Text("Sep 20, 2025", style: AppTextStyles.tileSubtitleTextStyle,),
                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded)),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }

  void _onRequestAccessTap(BuildContext context){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context, builder: (ctx){
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: RequestAccessPage(),
          );
    });
  }
}