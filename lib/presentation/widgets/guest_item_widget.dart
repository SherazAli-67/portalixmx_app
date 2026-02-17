
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';

import '../../core/models/visitor_model.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';
import '../../router/app_router.dart';

class GuestItemWidget extends StatelessWidget {
  const GuestItemWidget({
    super.key,
    required this.guest,
    required this.onDeleteTap,
    this.onTap
  });

  final GuestVisitor guest;
  final Function(GuestVisitor guest) onDeleteTap;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: .circular(15), side: BorderSide(color: AppColors.borderColor2)),
      child: ListTile(
        onTap: onTap ?? ()=> context.push(NamedRoutes.guestDetail.routeName, extra: guest),
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
  }
}