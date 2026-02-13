import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/res/app_colors.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/bg_gradient_screen.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/maintenance_provider.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/models/complaints_api_response.dart';
import '../../../../core/res/app_textstyles.dart';

class MaintenanceMenu extends StatelessWidget{
  const MaintenanceMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaintenanceProvider>(context,);
    return BgGradientScreen(
      floatingActionButton: FloatingActionButton(onPressed: ()=> provider.onAddComplaintTap(), shape: RoundedRectangleBorder(borderRadius: .circular(100)), child: Icon(Icons.add_rounded, color: AppColors.primaryColor,)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          spacing: 10,
          children: [
            Align(
                alignment: .center,
                child: Padding(
                  padding: const .only(top: 35.0, bottom: 11),
                  child: Text(AppLocalizations.of(context)!.maintenance, textAlign: .center, style: AppTextStyles.headingTextStyle,),
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: provider.allComplaints.length,
                    itemBuilder: (ctx, index){
                      ComplaintModel complaint = provider.allComplaints[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: ()=> context.push(NamedRoutes.complaintSummary.routeName, extra: complaint),
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text(complaint.complaint, style: AppTextStyles.tileTitleTextStyle),
                          subtitle: Text(DateTimeFormatHelpers.formatDateTime(complaint.createdAt), style: AppTextStyles.tileSubtitleTextStyle,),
                          trailing: PopupMenuButton(
                              elevation: 0,
                              color: Colors.white,
                              position: PopupMenuPosition.under,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.more_vert_rounded),
                              onSelected: (val){
                                provider.deleteComplaintByID(complaint.id);
                              },
                              itemBuilder: (ctx){
                                return [
                                  PopupMenuItem(
                                      value: 1,
                                      child: Text(AppLocalizations.of(context)!.deleteComplaint))
                                ];
                              }),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}