import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/features/main_menu/access/request_access_page.dart';
import 'package:portalixmx_app/models/access_control_api_response.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/request_access_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:provider/provider.dart';

import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class AccessMenu extends StatefulWidget{
  const AccessMenu({super.key});

  @override
  State<AccessMenu> createState() => _AccessMenuState();
}

class _AccessMenuState extends State<AccessMenu> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final requestAccessProvider = Provider.of<RequestAccessProvider>(context, listen: false);
      requestAccessProvider.getAllRequestControlList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestAccessProvider>(context);
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
                  Text(AppLocalizations.of(context)!.accessRequests, style: AppTextStyles.regularTextStyle,),
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
                      itemCount: provider.allAccessRequests.length,
                      itemBuilder: (ctx, index){
                        AccessRequestModel access = provider.allAccessRequests[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 15),
                            leading: SvgPicture.asset(AppIcons.icGame, colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                            title: Text(access.name, style: AppTextStyles.tileTitleTextStyle),
                            subtitle: Text(DateTimeFormatHelpers.formatDateTime(access.access.first.timeStamp), style: AppTextStyles.tileSubtitleTextStyle,),
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
