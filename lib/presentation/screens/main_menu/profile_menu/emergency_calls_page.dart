import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/core/common_ui.dart';
import 'package:portalixmx_app/core/models/user_model.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/loading_widget.dart';
import 'package:portalixmx_app/presentation/widgets/popup_menu_item_widget.dart';
import 'package:portalixmx_app/providers/emergency_calls_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class EmergencyCallsPage extends StatelessWidget {
  const EmergencyCallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmergencyCallsProvider(),
      builder: (ctx, _) {
        return Consumer<EmergencyCallsProvider>(builder: (ctx, provider, _) {
          final localization = AppLocalizations.of(context)!;
          return BgGradientScreen(
            floatingActionButton: FloatingActionButton(
              onPressed: () => provider.onAddContactsTap(ctx),
              backgroundColor: AppColors.btnColor,
              shape: RoundedRectangleBorder(borderRadius: .circular(100)),
              child: Icon(Icons.add_rounded, color: Colors.white,),
            ),
            child: Column(
              spacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 65.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButton(color: Colors.white),
                      Text(localization.emergencyCalls, style: AppTextStyles.regularTextStyle),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                Expanded(
                  child: Card(
                    color: AppColors.lightGreyBackgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(30),
                    ),
                    child: Padding(
                      padding: const .symmetric(horizontal: 15.0, vertical: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const .only(top: 35.0, bottom: 10),
                            child: Column(
                              spacing: 10,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTapDown: (_) => _onHoldStart(ctx, provider, localization),
                                  onTapUp: (_) => provider.cancelHold(),
                                  onTapCancel: () => provider.cancelHold(),
                                  child: SizedBox(
                                    width: 160,
                                    height: 160,
                                    child: Stack(
                                      alignment: .center,
                                      children: [
                                        SizedBox(
                                          width: 160,
                                          height: 160,
                                          child: CircularProgressIndicator(
                                            value: provider.holdProgress,
                                            strokeWidth: 5,
                                            color: AppColors.primaryColor,
                                            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.2),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 75,
                                          backgroundColor: AppColors.btnColor,
                                          child: Center(
                                            child: provider.isSending
                                                ? LoadingWidget()
                                                : Padding(
                                                    padding: const .symmetric(horizontal: 15.0),
                                                    child: Column(
                                                      spacing: 10,
                                                      mainAxisAlignment: .center,
                                                      children: [
                                                        SvgPicture.asset(AppIcons.icEmergencyCalls, height: 42,),
                                                        Text(localization.emergencyCall, textAlign: .center, style: AppTextStyles.regularTextStyle,),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(localization.holdToSendEmergency, textAlign: .center, style: AppTextStyles.tileSubtitleTextStyle,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: provider.loadingContacts
                                ? LoadingWidget(color: AppColors.primaryColor)
                                : provider.contacts.isEmpty
                                    ? Center(child: Text(localization.noEmergencyContacts, style: AppTextStyles.tileSubtitleTextStyle,))
                                    : ListView.builder(
                                        itemCount: provider.contacts.length,
                                        itemBuilder: (ctx, index) {
                                          final contact = provider.contacts[index];
                                          return _EmergencyContactTile(
                                            contact: contact,
                                            removeLabel: localization.removeContact,
                                            onRemove: () => provider.removeContact(contact.userID),
                                          );
                                        },
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void _onHoldStart(BuildContext context, EmergencyCallsProvider provider, AppLocalizations localization) {
    if (provider.contacts.isEmpty) {
      CommonUI.showSnackBarMessage(context, isError: true, message: localization.addEmergencyContactsFirst);
      return;
    }
    provider.startHold(onComplete: () async {
      final error = await provider.sendEmergencyAlert();
      if (!context.mounted) return;
      if (error == 'empty') {
        CommonUI.showSnackBarMessage(context, isError: true, message: localization.addEmergencyContactsFirst);
      } else if (error != null) {
        CommonUI.showSnackBarMessage(context, isError: true, message: localization.emergencyAlertFailed);
      } else {
        CommonUI.showSnackBarMessage(context, isSuccess: true, message: localization.emergencyAlertSent);
      }
    });
  }
}

class _EmergencyContactTile extends StatelessWidget {
  const _EmergencyContactTile({
    required this.contact,
    required this.removeLabel,
    required this.onRemove,
  });

  final UserModel contact;
  final String removeLabel;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(bottom: 10.0),
      child: Material(
        color: AppColors.lightGreyBackgroundColor,
        child: ListTile(
          contentPadding: const .only(top: 8, bottom: 8, left: 15, right: 4),
          shape: RoundedRectangleBorder(borderRadius: .circular(15)),
          leading: CircleAvatar(
            backgroundColor: AppColors.btnColor,
            child: Center(child: Icon(Icons.person, color: Colors.white,),),
          ),
          tileColor: Colors.white,
          title: Column(
            crossAxisAlignment: .start,
            children: [
              Text(contact.userName, style: AppTextStyles.tileTitleTextStyle,),
              if (contact.phoneNum != null && contact.phoneNum!.isNotEmpty)
                Text(contact.phoneNum!, style: AppTextStyles.tileSubtitleTextStyle,),
            ],
          ),
          trailing: PopupMenuButton(
            elevation: 0,
            color: Colors.white,
            position: .under,
            padding: .zero,
            icon: Icon(Icons.more_vert_rounded),
            onSelected: (_) => onRemove(),
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: PopupMenuItemWidget(icon: Icons.delete_outline, title: removeLabel),
                ),
              ];
            },
          ),
        ),
      ),
    );
  }
}
