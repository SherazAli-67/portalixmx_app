import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context,);
    final localization = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const .symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: .start,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      style: IconButton.styleFrom(backgroundColor: AppColors.btnColor),
                      onPressed: provider.onAddGuestTap, icon: Icon(Icons.add_rounded, color: Colors.white,)),
                ),
                FutureBuilder(future: provider.getCurrentUser(), builder: (ctx, snapshot){
                  UserModel? user = snapshot.data;
                  if(user != null){
                    return Row(
                      spacing: 10,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.btnColor,
                          child: Center(child:  Icon(Icons.person, color: Colors.white,),),
                        ),
                        Text(localization.welcomeMessage(user.userName), style: AppTextStyles.regularTextStyle,)
                      ],
                    );
                  }
                  return Text(localization.welcomeMessage(''), style: AppTextStyles.regularTextStyle,);
                }),
              ],
            ),
            Expanded(
            child:  Column(
              spacing: 20,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: provider.selectedTab == 0 ?  AppColors.btnColor : Colors.white),
                        onPressed: ()=> provider.onTabChange(0), child: Text(localization.regularVisitors, style: AppTextStyles.tabsTextStyle.copyWith(color: provider.selectedTab == 0 ?  Colors.white : AppColors.primaryColor),)),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: provider.selectedTab == 1 ?  AppColors.btnColor : Colors.white),
                        onPressed: ()=> provider.onTabChange(1), child: Text(localization.guest, style: AppTextStyles.tabsTextStyle.copyWith(color: provider.selectedTab == 1 ?  Colors.white : AppColors.primaryColor),)),

                  ],
                ),
                provider.selectedTab == 0
                    ? _buildAllVisitorPage(context, visitors: provider.regularVisitors, localization: localization,  onDeleteTap: (RegularVisitor visitor){})
                    : _buildAllGuestsPage(context, guests: provider.guests, localization: localization, onDeleteTap: (GuestVisitor guest){debugPrint("Delete method");})
              ],
            ),
          )
          ],
        ),
      ),
    );
  }

  Widget _buildAllVisitorPage(BuildContext context, {required List<RegularVisitor> visitors, required AppLocalizations localization, required Function(RegularVisitor guest) onDeleteTap}){
    return Expanded(
      child: ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (ctx, index){
            RegularVisitor visitor = visitors[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: ()=> context.push(NamedRoutes.guestDetail.routeName, extra: visitor),
                contentPadding: EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(child: Icon(Icons.person, color: Colors.white,),),
                ),
                title: Text(visitor.name, style: AppTextStyles.tileTitleTextStyle,),
                subtitle: Text(localization.regularVisitor, style: AppTextStyles.tileSubtitleTextStyle,),
                trailing: PopupMenuButton(
                    elevation: 0,
                    color: Colors.white,
                    position: PopupMenuPosition.under,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert_rounded),
                    onSelected: (_)=> onDeleteTap(visitor),
                    itemBuilder: (ctx){
                      return [
                        PopupMenuItem(
                            value: 1,
                            child: Text(localization.deleteVisitor))
                      ];
                    }),
              ),
            );
          }),
    );
  }

  Widget _buildAllGuestsPage(BuildContext context, {required List<GuestVisitor> guests, required Function(GuestVisitor guest) onDeleteTap, required AppLocalizations localization}){
    return Expanded(
      child: ListView.builder(
          itemCount: guests.length,
          itemBuilder: (ctx, index){
            GuestVisitor guest = guests[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: ()=> context.push(NamedRoutes.guestDetail.routeName, extra: guest),
                contentPadding: EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(
                    child:  Icon(Icons.person, color: Colors.white,),
                  ),
                ),
                title: Text(guest.name, style: AppTextStyles.tileTitleTextStyle,),
                subtitle: Text(localization.guest, style: AppTextStyles.tileSubtitleTextStyle,),
                trailing: PopupMenuButton(
                    elevation: 0,
                    color: Colors.white,
                    position: PopupMenuPosition.under,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert_rounded),
                    onSelected: (val){
                      onDeleteTap(guest);
                    },
                    itemBuilder: (ctx){
                      return [
                        PopupMenuItem(
                            value: 1,
                            child: Text(localization.deleteGuest))
                      ];
                    }),
              ),
            );
          }),
    );
  }
}
