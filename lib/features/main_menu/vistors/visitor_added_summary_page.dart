import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portalixmx_app/features/main_menu/vistors/widgets/vistor_info_item_widget.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../widgets/primary_btn.dart';

class VisitorAddedSummaryPage extends StatelessWidget{
  const VisitorAddedSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(child: Column(
        spacing: 20,
        children: [
          Padding(padding: EdgeInsets.only(top: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white,),
                Column(
                  children: [
                    Text("Name", style: AppTextStyles.regularTextStyle,),
                    Text("Guest", style: AppTextStyles.tileSubtitleTextStyle,)
                  ],
                ),
                IconButton(onPressed: ()=> _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
              ],
            ),
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
                          child: VisitorInfoItemWidget(title: 'NAME', subTitle: 'User Name', showDivider: true),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(title: 'CONTACT', subTitle: '+92 307 2215500',  showDivider: true)
                        ),
                      ],
                    ),

                    Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: VisitorInfoItemWidget(title: 'DATE', subTitle: 'Sep 20, 2024', ),
                        ),
                        Expanded(
                            child: VisitorInfoItemWidget(title: 'TIME', subTitle: '10:00AM - 06:00PM',)
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text("QR CODE", style: AppTextStyles.visitorDetailTitleTextStyle,),
                    Image.asset(AppIcons.icQRCode),
                    const Spacer(),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(bottom: 40),
                      width: double.infinity,
                      child: PrimaryBtn(onTap: (){}, btnText: "Share Key", color: AppColors.primaryColor,),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
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