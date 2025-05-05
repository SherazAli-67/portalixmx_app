import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/maintenance/add_complaint_page.dart';
import 'package:portalixmx_app/res/app_colors.dart';

import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class MaintenanceMenu extends StatelessWidget{
  const MaintenanceMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
                      itemCount: 5,
                      itemBuilder: (ctx, index){
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(left: 15),
                            title: Text("Complaint ABC", style: AppTextStyles.tileTitleTextStyle),
                            subtitle: Text("Sep 20, 2025", style: AppTextStyles.tileSubtitleTextStyle,),
                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.more_vert_rounded)),
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