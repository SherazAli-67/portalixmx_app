import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/router/app_router.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

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
                Text(AppLocalizations.of(context)!.guardTracking, style: AppTextStyles.regularTextStyle),
                const SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: Card(
              color: AppColors.lightGreyBackgroundColor,
              shape: RoundedRectangleBorder(borderRadius: .circular(30)),
              child: Padding(
                  padding: const .symmetric(horizontal: 15.0),
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index){
                        return Padding(
                          padding: const .only(bottom: 10.0),
                          child: Material(
                            color: AppColors.lightGreyBackgroundColor,
                            child: ListTile(
                              onTap: ()=> context.push(NamedRoutes.guardTracking.routeName),
                              contentPadding: .only(top: 8, bottom: 8, left: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: .circular(15)
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
                              trailing: IconButton(onPressed: ()=> context.push(NamedRoutes.guardTracking.routeName), icon: Icon(Icons.my_location, color: AppColors.primaryColor,)),
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