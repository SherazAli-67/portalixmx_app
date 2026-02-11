import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../../router/app_router.dart';
import '../../../widgets/bg_gradient_screen.dart';

class CommunityCalendarPage extends StatefulWidget {
  const CommunityCalendarPage({super.key});

  @override
  State<CommunityCalendarPage> createState() => _CommunityCalendarPageState();
}

class _CommunityCalendarPageState extends State<CommunityCalendarPage> {
   final TextEditingController _searchController = TextEditingController();


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


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
                Text(AppLocalizations.of(context)!.communityCalendar, style: AppTextStyles.regularTextStyle),
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
                            onTap: ()=> context.push(NamedRoutes.communityCalendarDetail.routeName),
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            tileColor: Colors.white,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Event name", style: AppTextStyles.tileTitleTextStyle,),
                                Text("Sep 20, 10:00 AM", style: AppTextStyles.tileSubtitleTextStyle,)
                              ],
                            ),
                            trailing: SizedBox(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(imageUrl: AppIcons.icComplaintImageUrl, fit: BoxFit.cover,)),
                            ),
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
