import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_calendar.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/community_polls_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/directory_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/edit_profile_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/emergency_calls_page.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/profile_guards_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';

class ProfileMenu extends StatelessWidget{
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 34,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              spacing: 5,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(AppIcons.icUserImageUrl),
                  ),
                ),
                Text("Muhammad Ali", style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.white),),
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                    },
                    child: Text(AppLocalizations.of(context)!.viewProfile, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),))
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileItemWidget(title: AppLocalizations.of(context)!.directory, icon: AppIcons.icDirectory,  onTap: ()=> _onDirectoryTap(context)),
              ProfileItemWidget(title: AppLocalizations.of(context)!.communityCalendar, icon: AppIcons.icCalendar, onTap: ()=> _onCommunityCalendarTap(context)),
              ProfileItemWidget(title: AppLocalizations.of(context)!.communityPolls, icon: AppIcons.icCommunityPolls,  onTap: ()=> _onCommunityPollsTap(context)),
              ProfileItemWidget(title: AppLocalizations.of(context)!.guards, icon: AppIcons.icGuards, onTap: ()=> _onGuardsTap(context)),
              ProfileItemWidget(title: AppLocalizations.of(context)!.carPooling, icon: AppIcons.icCarPooling, onTap: () {}),
              ProfileItemWidget(title: AppLocalizations.of(context)!.emergencyCalls, icon: AppIcons.icEmergencyCalls, onTap: ()=> _onEmergencyTap(context)),
              TextButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.privacyPolicy, style: AppTextStyles.tileTitleTextStyle2,)),
              TextButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.logout, style: AppTextStyles.tileTitleTextStyle2,)),

            ],
          )
        ],
      ),
    );
  }

  void _onDirectoryTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DirectoryPage()));
  }

  void _onCommunityCalendarTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CommunityCalendarPage()));
  }

  void _onCommunityPollsTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CommunityPollsPage()));
  }

  void _onGuardsTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ProfileGuardsPage()));
  }

  void _onEmergencyTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> EmergencyCallsPage()));
  }
}

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required String title, required String icon, required VoidCallback onTap,
  }) : _title = title, _icon = icon, _onTap = onTap;

  final String _title;
  final String _icon;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      contentPadding: EdgeInsets.only(left: 15),
      leading: SvgPicture.asset(_icon, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      title: Text(_title, style: AppTextStyles.tileTitleTextStyle2),
      trailing: IconButton(onPressed: _onTap, icon: Icon(Icons.navigate_next_rounded, color: Colors.white,)),
    );
  }
}