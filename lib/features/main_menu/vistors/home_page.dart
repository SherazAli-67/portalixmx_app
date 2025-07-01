import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/vistors/add_guest_page.dart';
import 'package:portalixmx_app/features/main_menu/vistors/visitor_detail_page.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/models/visitor_api_response.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:provider/provider.dart';

import '../../../widgets/loading_widget.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  String? token;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<HomeProvider>(context, listen: false);
      final userProvider = Provider.of<UserViewModel>(context, listen: false);
      // debugPrint("UserID: ${userProvider.userID}, Name: ${userProvider.userName}, email: ${userProvider.emailAddress}\nToken: ${userProvider.token}");
      token = userProvider.token;
      provider.getAllVisitors(token: token!);
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context,);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserViewModel>(builder: (ctx, provider, _){
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(

                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.btnColor
                        ),
                        onPressed: _onAddGuestTap, icon: Icon(Icons.add_rounded, color: Colors.white,)),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.btnColor,
                        child: Center(
                          child:  Icon(Icons.person, color: Colors.white,),
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.welcomeMessage(provider.userName!), style: AppTextStyles.regularTextStyle,)
                    ],
                  ),
                ],
              );
            }),
          Expanded(
            child: token == null ? LoadingWidget() : Column(
              spacing: 20,
              children: [
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 0 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selectedTab != 0){
                            _selectedTab = 0;
                            provider.getAllVisitors(token: token!);
                            setState(() {});
                          }
                        }, child: Text(AppLocalizations.of(context)!.regularVisitors, style: AppTextStyles.tabsTextStyle.copyWith(color: _selectedTab == 0 ?  Colors.white : AppColors.primaryColor),)),
            
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 1 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selectedTab != 1){
                            _selectedTab = 1;
                            provider.getAllGuests(token: token!);
                            setState(() {});
                          }
                        }, child: Text(AppLocalizations.of(context)!.guest, style: AppTextStyles.tabsTextStyle.copyWith(color: _selectedTab == 1 ?  Colors.white : AppColors.primaryColor),)),
            
                  ],
                ),
                _selectedTab == 0
                    ? _buildAllVisitorPage(visitors: provider.visitors)
                    : _buildAllGuestsPage(guests: provider.guests)
              ],
            ),
          )
          /*  */
          ],
        ),
      ),
    );
  }

  void _onAddGuestTap(){
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.82,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddGuestPage(token: token!,),
            ),
          );
        });
   /* showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context, builder: (ctx)=> AddGuestPage());*/
  }

  Widget _buildAllVisitorPage({required List<Visitor> visitors}){
    return Expanded(
      child: ListView.builder(
          itemCount: visitors.length,
          itemBuilder: (ctx, index){
            Visitor visitor = visitors[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage(visitor: visitor,))),
                contentPadding: EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(
                    child:  Icon(Icons.person, color: Colors.white,),
                  ),
                ),
                title: Text(visitor.name, style: AppTextStyles.tileTitleTextStyle,),
                subtitle: Text(visitor.type, style: AppTextStyles.tileSubtitleTextStyle,),
                trailing: PopupMenuButton(
                    elevation: 0,
                    color: Colors.white,
                    position: PopupMenuPosition.under,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (ctx){
                      return [
                        PopupMenuItem(child: Text("Menu Item"))
                      ];
                    }),
              ),
            );
          }),
    );
  }

  Widget _buildAllGuestsPage({required List<Guest> guests}){
    return Expanded(
      child: ListView.builder(
          itemCount: guests.length,
          itemBuilder: (ctx, index){
            Guest guest = guests[index];
            return Card(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage(guest: guest,))),
                contentPadding: EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(
                    child:  Icon(Icons.person, color: Colors.white,),
                  ),
                ),
                title: Text(guest.name, style: AppTextStyles.tileTitleTextStyle,),
                subtitle: Text(guest.type, style: AppTextStyles.tileSubtitleTextStyle,),
                trailing: PopupMenuButton(
                    elevation: 0,
                    color: Colors.white,
                    position: PopupMenuPosition.under,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert_rounded),
                    itemBuilder: (ctx){
                      return [
                        PopupMenuItem(child: Text("Menu Item"))
                      ];
                    }),
              ),
            );
          }),
    );
  }
}
