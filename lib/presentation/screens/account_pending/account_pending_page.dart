import 'package:flutter/material.dart';
import 'package:portalixmx_app/services/auth_service/auth_service.dart';

import '../../../core/res/app_icons.dart';
import '../../../core/res/app_textstyles.dart';
import '../../../l10n/app_localizations.dart';

class PendingRequestPage extends StatelessWidget {
  const PendingRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Center(child: Padding(
          padding: const .symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: .center,
              spacing: 10,
              children: [
                Image.asset(AppIcons.accountPending, height: 48, width: 48, color: Colors.white,),
                FutureBuilder(future: AuthService.instance.getSociety(), builder: (ctx, snapshot){
                  String societyName = snapshot.data?.name ?? 'Society';
                  return Text(localization.accountRequestPending(societyName), style: AppTextStyles.regularTextStyle, textAlign: .center,);
                })
          ]),
        )),
      ),
    );
  }
}
