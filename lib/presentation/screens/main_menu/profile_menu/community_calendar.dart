import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/models/community_event_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/providers/community_calendar_provider.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:provider/provider.dart';
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
    return ChangeNotifierProvider(
      create: (_)=> CommunityCalendarProvider(),
      builder: (ctx, provider){
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
                      child: Consumer<CommunityCalendarProvider>(
                        builder: (ctx, provider, child){
                          return provider.loadingCommunityEvents
                              ? LoadingWidget(color: AppColors.primaryColor,)
                              : provider.communityEvents.isEmpty ? Center(child: Text("No Events yet",),)
                              : ListView.builder(
                              itemCount: provider.communityEvents.length,
                              itemBuilder: (ctx, index){
                                CommunityEventModel event = provider.communityEvents[index];
                                return Padding(
                                  padding: const .only(bottom: 10.0),
                                  child: Material(
                                    color: AppColors.lightGreyBackgroundColor,
                                    child: ListTile(
                                      onTap: ()=> context.push(NamedRoutes.communityCalendarDetail.routeName, extra: event),
                                      contentPadding: .symmetric(vertical: 8, horizontal: 15),
                                      shape: RoundedRectangleBorder(borderRadius: .circular(15)),
                                      tileColor: Colors.white,
                                      title: Column(
                                        crossAxisAlignment: .start,
                                        children: [
                                          Text(event.eventTitle, style: AppTextStyles.tileTitleTextStyle,),
                                          Text(DateTimeFormatHelpers.getCommunityDateTime(event.createdAt, event.eventTime), style: AppTextStyles.tileSubtitleTextStyle,)
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
                              });
                        },
                      )
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
