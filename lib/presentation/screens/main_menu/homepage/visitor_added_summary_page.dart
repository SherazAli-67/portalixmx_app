import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../../core/app_data/app_data.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/primary_btn.dart';
import 'widgets/vistor_info_item_widget.dart';

class VisitorAddedSummaryPage extends StatelessWidget{
  const VisitorAddedSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
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
                    Text(localization.name, style: AppTextStyles.regularTextStyle,),
                    Text(localization.visitorType, style: AppTextStyles.tileSubtitleTextStyle,)
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
                child: _buildRegularVisitorWidget(context, localization),
              ),
            ),
          )
        ],
      ),);
  }

  Widget _buildRegularVisitorWidget(BuildContext context, AppLocalizations localization) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: VisitorInfoItemWidget(
                    title: localization.requestedTime, subTitle: 'Sep 20, 2024', showDivider: true),
              ),
              Expanded(
                  child: VisitorInfoItemWidget(title: localization.accessFor,
                      subTitle: localization.teacher,
                      showDivider: true)
              ),
            ],
          ),
      
          Row(
            spacing: 20,
            children: [
              Expanded(
                child: VisitorInfoItemWidget(
                  title: localization.accessApprovedDate, subTitle: 'Sep 20, 2024',),
              ),
              Expanded(
                  child: VisitorInfoItemWidget(
                    title: localization.contactNum, subTitle: '+91 12345678',)
              ),
            ],
          ),
      
          Column(
              children: List.generate(7, (index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppData.getDays(context)[index], style: AppTextStyles.visitorDetailTitleTextStyle,),
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
          const SizedBox(height: 20,),
          Text(localization.qrCode, style: AppTextStyles.visitorDetailTitleTextStyle,),
          Image.asset(AppIcons.icQRCode),
          Container(
            height: 50,
            margin: EdgeInsets.only(bottom: 40),
            width: double.infinity,
            child: PrimaryBtn(
              onTap: () {}, btnText: localization.shareKey, bgColor: AppColors.primaryColor,),
          )
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context){
    final localization = AppLocalizations.of(context)!;
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context, builder: (ctx){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            _buildEditDeleteItem(icon: AppIcons.icEdit, text: localization.edit, onTap: (){}),
            _buildEditDeleteItem(icon: AppIcons.icDelete, text: localization.delete, onTap: (){}),

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
