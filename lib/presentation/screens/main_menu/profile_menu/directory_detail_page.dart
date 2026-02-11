import 'package:flutter/material.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../homepage//widgets/vistor_info_item_widget.dart';

class DirectoryDetailPage extends StatelessWidget{
  const DirectoryDetailPage({super.key});

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
              Text("Name", style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 20)
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
                  spacing: 15,
                  children: [
                    VisitorInfoItemWidget(
                      title: 'Apart No.', subTitle: '1223',showDivider: true,),
                    VisitorInfoItemWidget(
                      title: 'Contact', subTitle: '+92 307 2215500',showDivider: true,)
                  ],
                )
            ),
          ),
        )
      ],
    ),);
  }

}