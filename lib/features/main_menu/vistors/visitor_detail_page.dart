import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_app/app_data/app_data.dart';
import 'package:portalixmx_app/features/main_menu/vistors/widgets/vistor_info_item_widget.dart';
import 'package:portalixmx_app/models/guest_api_response.dart';
import 'package:portalixmx_app/models/visitor_api_response.dart';
import 'package:portalixmx_app/providers/datetime_format_helpers.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_icons.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/bg_gradient_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VisitorDetailPage extends StatelessWidget{
  const VisitorDetailPage({super.key, Guest? guest, Visitor? visitor}): _guest = guest, _visitor = visitor;
  final Guest? _guest;
  final Visitor? _visitor;

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Column(
          spacing: 11,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                Column(
                  children: [
                    Text(_guest != null ? _guest.name :_visitor!.name, style: AppTextStyles.regularTextStyle,),
                    Text(_guest != null ? 'Guest' : 'Regular Visitor', style: AppTextStyles.tileSubtitleTextStyle,)
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                  child: Column(
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: VisitorInfoItemWidget(
                                title: 'REQUESTED TIME',
                                subTitle: _guest != null
                                    ? DateTimeFormatHelpers.formatDateTime(
                                    _guest.createdAt)
                                    : DateTimeFormatHelpers.formatDateTime(
                                    _visitor!.createdAt),
                                showDivider: true),
                          ),
                          Expanded(
                              child: VisitorInfoItemWidget(title: 'ACCESS FOR', subTitle: 'Teacher',  showDivider: true)
                          ),
                        ],
                      ),
              
                      Row(
                        spacing: 20,
                        children: [
                          Expanded(
                            child: VisitorInfoItemWidget(title: 'Access Approved Date', subTitle:_guest != null
                                ? DateTimeFormatHelpers.formatDateTime(
                                _guest.createdAt)
                                : DateTimeFormatHelpers.formatDateTime(
                                _visitor!.createdAt), ),
                          ),
                          Expanded(
                              child: VisitorInfoItemWidget(title: 'Contact No', subTitle: _guest != null
                                  ? _guest.contactNumber
                                  : _visitor!.contactNumber,)
                          ),
                        ],
                      ),
                      Divider(),
                      _guest != null ? _buildGuestDetailPage() : _buildVisitorDetailPage()

                    ],
                  ),
                ),
              ),
            )
          ],
        ));
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

  Widget _buildGuestDetailPage() {
    return Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("From",
                      style: AppTextStyles.visitorDetailTitleTextStyle,),
                    Text('${DateFormat('EEEE').format(_guest!.fromDate)} - ${_guest.fromTime}',
                      style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.dividerColor,
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("To",
                      style: AppTextStyles.visitorDetailTitleTextStyle,),
                    Text('${DateFormat('EEEE').format(_guest.toDate)} - ${_guest.toTime}',
                      style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: AppColors.dividerColor,
              ),
            ],
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              height: 200,
              child: QrImageView(data: _guest.id,),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: PrimaryBtn(onTap: (){}, btnText: "Share Key", color: AppColors.primaryColor,),
          )
        ],
    );
  }

  Widget _buildVisitorDetailPage() {
    return Column(
      children: [
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
    );
  }
}