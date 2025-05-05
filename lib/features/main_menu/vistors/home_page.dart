import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/vistors/add_guest_page.dart';
import 'package:portalixmx_app/features/main_menu/vistors/visitor_detail_page.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selecteedTab = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(

                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.btnColor
                  ),
                  onPressed: _onAddGuestTap, icon: Icon(Icons.add_rounded, color: Colors.white,)),
            ),
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.btnColor,
                  child: Center(
                    child:  Icon(Icons.person, color: Colors.white,),
                  ),
                ),
                Text("Welcome Alex!", style: AppTextStyles.regularTextStyle,)
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              spacing: 20,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selecteedTab == 0 ?  AppColors.btnColor : Colors.white
                    ),
                    onPressed: (){}, child: Text("Regular Visitors", style: AppTextStyles.tabsTextStyle.copyWith(color: _selecteedTab == 0 ?  Colors.white : AppColors.primaryColor),)),

                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _selecteedTab == 1 ?  AppColors.btnColor : Colors.white
                    ),
                    onPressed: (){}, child: Text("Guest", style: AppTextStyles.tabsTextStyle.copyWith(color: _selecteedTab == 1 ?  Colors.white : AppColors.primaryColor),)),

              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (ctx, index){
                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage())),
                        contentPadding: EdgeInsets.only(left: 10),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.btnColor,
                          child: Center(
                            child:  Icon(Icons.person, color: Colors.white,),
                          ),
                        ),
                        title: Text("Name", style: AppTextStyles.tileTitleTextStyle,),
                        subtitle: Text("Teachers", style: AppTextStyles.tileSubtitleTextStyle,),
                        trailing: PopupMenuButton(
                          elevation: 0,
                          color: Colors.white,
                          position: PopupMenuPosition.under,
                          padding: EdgeInsets.zero,
                            icon: Icon(Icons.more_vert_rounded),
                            itemBuilder: (ctx){
                          return [
                            PopupMenuItem(child: Text("Menu Item"))
                          ];
                        }),
                      ),
                    );
              }),
            )
          ],
        ),
      ),
    );
  }

  void _onAddGuestTap(){
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.82,
            child: AddGuestPage(),
          );
        });
   /* showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context, builder: (ctx)=> AddGuestPage());*/
  }
}