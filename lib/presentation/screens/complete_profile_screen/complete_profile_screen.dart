import 'package:flutter/material.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_icons.dart';
import '../../../core/res/app_textstyles.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _phoneNumController = .new();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return ScreenWithBgLogo(
      child: Padding(
        padding: .all(16),
        child: Column(
          spacing: 16,
          children: [
            Text(localization.completeProfile, style: AppTextStyles.headingTextStyle,),
            Text(localization.completeProfileDescription, style: AppTextStyles.subHeadingTextStyle, textAlign: .center,),

            Expanded(
              child: SingleChildScrollView(padding: .only(top: 16), child: Column(
                spacing: 16,
                crossAxisAlignment: .start,
                children: [
                  Align(
                    alignment: .center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 41,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40,
                              // backgroundImage: provider.pickedImage != null
                              //     ? FileImage(File(provider.pickedImage!.path))
                              //     : null,
                              backgroundImage: AssetImage(AppIcons.icSplashLogo),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: .circle,
                                  color: AppColors.btnColor
                              ),
                              padding: .all(5),
                              child: Icon(
                                Icons.edit, color: Colors.white, size: 18,),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  AppTextField(title: localization.phone, controller: _phoneNumController, hintText: localization.phone, textInputType: .number,),
                  Text(localization.vehicleInformation, style:AppTextStyles.btnTextStyle),
                  AppTextField(hintText: localization.vehicleName,),
                  AppTextField(hintText: localization.color,),
                  AppTextField(hintText: localization.licensePlateNumber,),
                  AppTextField(hintText: localization.registrationNumber,),
                  Text(localization.emergencyContacts, style:AppTextStyles.btnTextStyle),
                  AppTextField(hintText: localization.contactNum, textInputType: .number,),
                  SizedBox(
                    width: .infinity,
                    child: PrimaryBtn(onTap: (){}, btnText: localization.submit),
                  )
                ],
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
