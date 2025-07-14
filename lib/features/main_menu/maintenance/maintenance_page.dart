import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/maintenance/add_complaint_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/models/complaints_api_response.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/providers/maintenance_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class MaintenanceMenu extends StatefulWidget{
  const MaintenanceMenu({super.key});

  @override
  State<MaintenanceMenu> createState() => _MaintenanceMenuState();
}

class _MaintenanceMenuState extends State<MaintenanceMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<MaintenanceProvider>(context, listen: false);
      provider.getAllComplaints();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaintenanceProvider>(context,);
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
                  BackButton(color: Colors.white,),
                  Text("Maintenance", style: AppTextStyles.regularTextStyle,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.btnColor
                      ),
                      onPressed: ()=> _onAddComplaintTap(context), child: Text("Add", style: AppTextStyles.subHeadingTextStyle.copyWith(color: Colors.white),))
                ],
              ),
              const SizedBox(height: 40,),
              Expanded(
                  child: ListView.builder(
                      itemCount: provider.allComplaints.length,
                      itemBuilder: (ctx, index){
                        Complaint complaint = provider.allComplaints[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
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
        ));
  }

  void _onAddComplaintTap(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context, builder: (ctx){
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: AddComplaintPage(),
          );
    });
  }
}