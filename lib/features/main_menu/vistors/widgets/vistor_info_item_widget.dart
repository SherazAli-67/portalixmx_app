import 'package:flutter/material.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/app_textstyles.dart';

class VisitorInfoItemWidget extends StatelessWidget{
  final String _title;
  final String _subtitle;
  final bool _showDivider;

  const VisitorInfoItemWidget({super.key, required String title, required String subTitle, bool showDivider = false}): _title = title, _subtitle = subTitle, _showDivider = showDivider;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_title, style: AppTextStyles.visitorDetailTitleTextStyle,),
        Text(_subtitle, style: AppTextStyles.visitorDetailSubtitleTextStyle,),
        const SizedBox(height: 20,),
        if(_showDivider)
          Divider(color: AppColors.dividerColor,)
      ],
    );
  }

}