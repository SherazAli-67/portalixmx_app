import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/payments_menu.dart';
import 'package:portalixmx_app/features/main_menu/profile_menu/profile_page.dart';
import 'package:portalixmx_app/features/main_menu/vistors/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../providers/tab_change_provider.dart';
import '../../res/app_colors.dart';
import '../../res/app_icons.dart';
import 'access/access_page.dart';
import 'maintenance/maintenance_page.dart';
class MainMenuPage extends StatelessWidget{
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TabChangeProvider>(builder: (ctx, provider, _){
      return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 110,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
              onTap: (index)=> provider.onTabChange(index),
              backgroundColor: AppColors.primaryColor,
              showSelectedLabels: false,
              unselectedItemColor: Colors.white,
              currentIndex: provider.currentIndex,
              selectedLabelStyle: TextStyle(fontSize: 11),
              unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.white),

              items: [
                _buildBottomNavigationItemWidget(icon: AppIcons.icHomeMenu, label: 'Home', isSelected: provider.currentIndex == 0),
                _buildBottomNavigationItemWidget(icon: AppIcons.icPaymentsMenu, label: 'Payments', isSelected: provider.currentIndex == 1),
                _buildBottomNavigationItemWidget(icon: AppIcons.icMaintenance, label: 'Maintenance', isSelected: provider.currentIndex == 2),
                _buildBottomNavigationItemWidget(icon: AppIcons.icAccess, label: 'Access', isSelected: provider.currentIndex == 3),
                _buildBottomNavigationItemWidget(icon: AppIcons.icMenu, label: 'Menu', isSelected: provider.currentIndex == 4),

              ]),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height*0.7,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    AppColors.btnColor,
                    AppColors.btnColor.withOpacity(0.0)

                  ])
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 50,
              child: Image.asset(AppIcons.icScreenBg, height: 150,),
            ),
            SafeArea(child: _buildPage(provider.currentIndex)),
          ],
        ),
      );
    },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationItemWidget({required String icon, required String label, required bool isSelected}) =>
    BottomNavigationBarItem(
        icon: isSelected ? Container(
          padding: const EdgeInsets.all(12.0),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: AppColors.btnColor,
            shape: BoxShape.circle
          ),
          child: SvgPicture.asset(icon, height: 25, ),
        ) : SvgPicture.asset(icon, height: 25, ), label: isSelected ? '': label,);

  Widget _buildPage(int currentIndex) {
    switch(currentIndex){
      case 0:
        return HomePage();

      case 1:
        return PaymentsMenu();

      case 2:
        return MaintenanceMenu();

      case 3:
        return AccessMenu();

      case 4:
        return ProfileMenu();

      default:
        return HomePage();
    }
  }

}