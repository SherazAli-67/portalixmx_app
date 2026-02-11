import 'package:flutter/material.dart';
import '../../../../core/res/app_colors.dart';
import '../../../../core/res/app_icons.dart';
import '../../../../core/res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class GuardTrackingMapPage extends StatelessWidget{
  const GuardTrackingMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 65.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(color: Colors.white),
                  Text("Guard Tracking", style: AppTextStyles.regularTextStyle),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppIcons.icMap, fit: BoxFit.cover,),
                Image.asset(AppIcons.icMyLocation)
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 35,
                child: Center(child: IconButton(onPressed: (){}, icon: Icon(Icons.call, color: AppColors.primaryColor,)),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}