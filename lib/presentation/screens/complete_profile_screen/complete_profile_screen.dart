import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/helpers/auth_error_localizer.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../core/common_ui.dart';
import '../../../core/res/app_colors.dart';
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
  final TextEditingController _phoneNumController = TextEditingController();
  final TextEditingController _vehicleName = TextEditingController();
  final TextEditingController _vehicleColor = TextEditingController();
  final TextEditingController _licensePlateNum = TextEditingController();
  final TextEditingController _registrationNum = TextEditingController();
  final TextEditingController _emergencyContactNum = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumController.dispose();
    _vehicleName.dispose();
    _vehicleColor.dispose();
    _licensePlateNum.dispose();
    _registrationNum.dispose();
    _emergencyContactNum.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            Text(localization.completeProfile, style: AppTextStyles.headingTextStyle,),
            Text(localization.completeProfileDescription, style: AppTextStyles.subHeadingTextStyle, textAlign: TextAlign.center,),

            Expanded(
              child: Consumer<AuthenticationProvider>(
                builder: (context, provider, _) {
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: provider.onPickImageTap,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 41,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: provider.pickedImage != null
                                          ? FileImage(File(provider.pickedImage!.path))
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 2,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.btnColor
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: const Icon(
                                        Icons.edit, color: Colors.white, size: 18,),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          AppTextField(title: localization.phone, controller: _phoneNumController, hintText: localization.phone, textInputType: TextInputType.number, validator: Validators.validatePhone(localization),),
                          Text(localization.vehicleInformation, style: AppTextStyles.btnTextStyle),
                          AppTextField(hintText: localization.vehicleName, controller: _vehicleName, validator: Validators.validateMinLength(localization, emptyMessage: localization.pleaseEnterVehicleName, minLengthMessage: localization.vehicleNameMinLength),),
                          AppTextField(hintText: localization.color, controller: _vehicleColor, validator: Validators.validateMinLength(localization, emptyMessage: localization.pleaseEnterVehicleColor, minLengthMessage: localization.colorMinLength),),
                          AppTextField(hintText: localization.licensePlateNumber, controller: _licensePlateNum, validator: Validators.validateLicensePlate(localization),),
                          AppTextField(hintText: localization.registrationNumber, controller: _registrationNum, validator: Validators.validateRequired(localization, localization.pleaseEnterRegistrationNumber),),
                          Text(localization.personalEmergencyPhone, style: AppTextStyles.btnTextStyle),
                          AppTextField(hintText: localization.contactNum, textInputType: TextInputType.number, controller: _emergencyContactNum, validator: Validators.validatePhone(localization),),
                          SizedBox(
                            width: double.infinity,
                            child: PrimaryBtn(
                              onTap: _onSignupTap,
                              btnText: localization.submit,
                              isLoading: provider.isCompletingProfile,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSignupTap()async{
    if (!(_formKey.currentState?.validate() ?? false)) return;
    String phoneNum = _phoneNumController.text.trim();
    String vehicleName = _vehicleName.text.trim();
    String color = _vehicleColor.text.trim();
    String licensePlateNum = _licensePlateNum.text.trim();
    String registrationNum = _registrationNum.text.trim();
    String emergencyContact = _emergencyContactNum.text.trim();

    final provider = Provider.of<AuthenticationProvider>(context, listen: false);

    String? isError = await provider.onCompleteProfileTap(
      phoneNum: phoneNum,
      vehicleName: vehicleName,
      vehicleColor: color,
      licensePlateNum: licensePlateNum,
      registrationNum: registrationNum,
      personalEmergencyPhone: emergencyContact,
    );
    if (!mounted) return;
    if(isError != null){
      CommonUI.showSnackBarMessage(context, isError: true, message: AuthErrorLocalizer.localize(AppLocalizations.of(context)!, isError), title: AppLocalizations.of(context)!.signupFailed);
    }else{
      context.go(NamedRoutes.home.routeName);
    }
  }
}
