import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/models/society_model.dart';
import 'package:portalixmx_app/core/helpers/auth_error_localizer.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/presentation/widgets/app_dropdown_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/common_ui.dart';
import '../../../core/res/app_colors.dart';
import '../../../core/res/app_constants.dart';
import '../../../core/res/app_textstyles.dart';
import '../../../providers/authentication_provider/authentication_provider.dart';
import '../../../router/app_router.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late AuthenticationProvider _provider;

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _houseNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    _provider = Provider.of<AuthenticationProvider>(context);
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(localization.createAccount, style: AppTextStyles.headingTextStyle),
            Text(localization.createAccountDescription, style: AppTextStyles.subHeadingTextStyle, textAlign: TextAlign.center,),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: _provider.onPickImageTap,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                  radius: 41,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: _provider.pickedImage != null
                                        ? FileImage(File(_provider.pickedImage!.path))
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
                                  child: const Icon(Icons.edit, color: Colors.white, size: 18,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      AppTextField(title: localization.name, controller: _nameController, hintText: localization.name,validator: Validators.validateFullName(localization),),
                      AppTextField(title: localization.email, controller: _emailController, hintText: localization.email,textInputType: TextInputType.emailAddress, validator: Validators.validateEmail(localization),),
                      AppTextField(title: localization.password, controller: _passwordController, hintText: localization.password, isPassword: true, validator: Validators.validatePassword(localization),),
                      AppTextField(title: localization.houseNumber, controller: _houseNumberController, hintText: localization.houseNumber, validator: Validators.validateHouseNumber(localization),),
                      AppTextField(title: localization.address, controller: _addressController, hintText: localization.address, validator: Validators.validateAddress(localization), maxLines: 2,),
                      if (_provider.loadingSocieties)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (_provider.societiesError != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 8,
                          children: [
                            Text(
                              localization.failedToLoadSocieties,
                              style: AppTextStyles.regularTextStyle.copyWith(color: Colors.red),
                            ),
                            TextButton(
                              onPressed: _provider.loadSocieties,
                              child: Text(localization.retry),
                            ),
                          ],
                        )
                      else
                        AppDropdownWidget<SocietyModel>(
                          title: localization.selectSociety,
                          list: _provider.societies,
                          value: _provider.selectedSociety,
                          onChanged: (val) => _provider.onSelectSocietyTap(val),
                          getTitle: (item) => item.name,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(
                  onTap: _onSignupTap, btnText: localization.createAccount, isLoading: _provider.isSigningUp,),
            ),
            RichText(text: TextSpan(
                text: localization.alreadyHaveAnAccount,
                style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily),
                children: [
                  TextSpan(
                      text: localization.login,
                      recognizer: TapGestureRecognizer()..onTap = ()=> context.go(NamedRoutes.login.routeName),
                      style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily, fontWeight: FontWeight.w600)
                  )
                ]
            ))
          ],
        ),
      ),
    );
  }

  void _onSignupTap() async {
    if(_formKey.currentState?.validate() ?? false){
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String houseNumber = _houseNumberController.text.trim();
      String address = _addressController.text.trim();
      String? isError = await _provider.onCreateAccountTap(name: name, email: email, password: password, houseNumber: houseNumber, address: address);
      if (!mounted) return;
      if(isError != null){
        CommonUI.showSnackBarMessage(context, isError: true, message: AuthErrorLocalizer.localize(AppLocalizations.of(context)!, isError), title: AppLocalizations.of(context)!.signupFailed);
      }else{
        if (!mounted) return;
        if(mounted) {
          context.push(NamedRoutes.completeProfile.routeName);
        }
      }
    }
  }
}
