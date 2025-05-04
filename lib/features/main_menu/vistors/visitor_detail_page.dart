import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';

class VisitorDetailPage extends StatelessWidget{
  const VisitorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
        paddingFromTop: 50,
        child:  Column(
          spacing: 11,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                Column(
                  children: [
                    Text("Name", style: AppTextStyles.regularTextStyle,),
                    Text("Regular Visitor", style: AppTextStyles.tileSubtitleTextStyle,)
                  ],
                ),
                IconButton(onPressed: ()=> _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
              ],
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                  child: Column(
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: _buildInfoItemWidget(title: 'REQUESTED TIME', subTitle: 'Sep 20, 10:00 AM', showDivider: true),
                          ),
                          Expanded(
                              child: _buildInfoItemWidget(title: 'ACCESS FOR', subTitle: 'Teacher',  showDivider: true)
                          ),
                        ],
                      ),
              
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: _buildInfoItemWidget(title: 'Access Approved Date', subTitle: 'Sep 20, 2024', ),
                          ),
                          Expanded(
                              child: _buildInfoItemWidget(title: 'Contact No', subTitle: '+91 12345678',)
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                          children: List.generate(7, (index){
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppData.days[index], style: AppTextStyles.visitorDetailTitleTextStyle,),
                                      Text("10:00AM - 06:00PM", style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    color: AppColors.dividerColor,
                                  ),
                                ],
                              ),
                            );
                          })
                      ),
                      Text("QR CODE", style: AppTextStyles.visitorDetailTitleTextStyle,),
                      Image.asset(AppIcons.icQRCode),
                      const SizedBox(height: 20,),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: PrimaryBtn(onTap: (){}, btnText: "Share Key", color: AppColors.primaryColor,),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildInfoItemWidget({required String title, required String subTitle, bool showDivider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.visitorDetailTitleTextStyle,),
        Text(subTitle, style: AppTextStyles.visitorDetailSubtitleTextStyle,),
        const SizedBox(height: 20,),
        if(showDivider)
        Divider(color: AppColors.dividerColor,)
      ],
    );
  }

  void _showEditBottomSheet(BuildContext context){
     showModalBottomSheet(
         backgroundColor: Colors.white,
         context: context, builder: (ctx){
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 35),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           spacing: 10,
           children: [
             _buildEditDeleteItem(icon: AppIcons.icEdit, text: "Edit", onTap: (){}),
             _buildEditDeleteItem(icon: AppIcons.icDelete, text: "Delete", onTap: (){}),

           ],
         ),
       );
     });
  }

  Row _buildEditDeleteItem({required String icon, required String text, required VoidCallback onTap}) {
    return Row(
      spacing: 20,
      children: [
        IconButton(
            onPressed: onTap, icon: SvgPicture.asset(icon)),
        Text(text, style: AppTextStyles.visitorDetailSubtitleTextStyle,)
      ],
    );
  }
}