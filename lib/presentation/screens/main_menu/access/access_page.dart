import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/request_access_provider.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/access_request_model.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class AccessMenu extends StatelessWidget{
  const AccessMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return ChangeNotifierProvider(
      create: (_) => RequestAccessProvider(),
      builder: (ctx, _){
        return  Consumer<RequestAccessProvider>(
          builder: (ctx, provider, _){
            return BgGradientScreen(
                paddingFromTop: 50,
                child: Stack(
                  children: [
                    Padding(
                      padding: const .symmetric(horizontal: 10.0),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              const SizedBox(width: 40,),
                              Text(localization.accessRequests, style: AppTextStyles.regularTextStyle,),
                              IconButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.btnColor),
                                  onPressed: ()=> provider.onAddRequestTap(), icon: Icon(Icons.add, color: Colors.white,)),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: provider.allAccessRequests.length,
                                  itemBuilder: (ctx, index){
                                    AccessRequestModel access = provider.allAccessRequests[index];
                                    return Card(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: ListTile(
                                        onTap: ()=> context.push(NamedRoutes.accessRequestDetail.routeName, extra: access),
                                        contentPadding: EdgeInsets.only(left: 15),
                                        leading: SvgPicture.asset(AppIcons.icGame, colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                                        title: Text(access.requestedAccessTitle, style: AppTextStyles.tileTitleTextStyle),
                                        subtitle: Text(DateTimeFormatHelpers.formatDateTime(access.createdAt), style: AppTextStyles.tileSubtitleTextStyle,),
                                        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded)),
                                      ),
                                    );
                                  }))
                        ],
                      ),
                    ),
                    if(provider.addingRequestAccess)
                      LoadingWidget(color: Colors.white,)
                  ],
                ));
          },
        );
      },
    );
  }
}
