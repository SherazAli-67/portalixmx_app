import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/models/visitor_model.dart';
import 'package:portalixmx_app/presentation/widgets/full_page_loading_widget.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/guest_item_widget.dart';
import '../../../widgets/regular_visitor_item_widget.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context,);
    final localization = AppLocalizations.of(context)!;
    return Stack(
      children: [
        SafeArea(
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
                      child: PopupMenuButton(
                          elevation: 0,
                          color: Colors.white,
                          position: PopupMenuPosition.under,
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.add, color: Colors.white,),
                          style: IconButton.styleFrom(backgroundColor: AppColors.btnColor),
                          onSelected: (val) {
                            if (val == 1) {
                              provider.onAddGuestTap();
                            }
                          },
                          itemBuilder: (ctx) {
                            return [
                              PopupMenuItem(
                                value: 1,
                                child: Text(localization.addGuest),
                              ),
                            ];
                          }),
                      /*      IconButton(
                              style: IconButton.styleFrom(backgroundColor: AppColors.btnColor),
                              onPressed: provider.onAddGuestTap, icon: Icon(Icons.add_rounded, color: Colors.white,)),*/
                    ),
                    FutureBuilder(future: provider.getCurrentUser(), builder: (ctx, snapshot){
                      UserModel? user = snapshot.data;
                      if(user != null){
                        return Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.btnColor,
                              backgroundImage: user.profileImg != null ? CachedNetworkImageProvider(user.profileImg!) : null,
                              child: user.profileImg == null ? Center(child:  Icon(Icons.person, color: Colors.white,),) : null,
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
                  child: Column(
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
                          ? _buildAllVisitorPage(
                          context, visitors: provider.regularVisitors,
                          onDeleteTap: (RegularVisitor visitor) => provider.deleteVisitor(visitor.id),
                          onRefresh: provider.refreshVisitorsAndGuests)
                          : _buildAllGuestsPage(context, guests: provider.guests,
                          onDeleteTap: (GuestVisitor guest) => provider.deleteVisitor(guest.id),
                          onRefresh: provider.refreshVisitorsAndGuests)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if(provider.loading)
          FullPageLoadingWidget()
      ],
    );
  }

  Widget _buildAllVisitorPage(BuildContext context, {required List<RegularVisitor> visitors,required Function(RegularVisitor guest) onDeleteTap, required Future<void> Function() onRefresh}){
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: visitors.length,
            separatorBuilder: (ctx, index) => const SizedBox(height: 10,),
            itemBuilder: (ctx, index){
              RegularVisitor visitor = visitors[index];
              return RegularVisitorItemWidget(visitor: visitor, onDeleteTap: onDeleteTap,);
            }),
      ),
    );
  }

  Widget _buildAllGuestsPage(BuildContext context, {required List<GuestVisitor> guests, required Function(GuestVisitor guest) onDeleteTap, required Future<void> Function() onRefresh, }){
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: guests.length,
            separatorBuilder: (ctx, index) => const SizedBox(height: 10,),
            itemBuilder: (ctx, index){
              GuestVisitor guest = guests[index];
              return GuestItemWidget(guest: guest, onDeleteTap: onDeleteTap,);
            }),
      ),
    );
  }
}

