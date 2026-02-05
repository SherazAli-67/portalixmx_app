import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/res/app_colors.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/router/app_router.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';
import '../../res/app_constants.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final TextEditingController _emailController = .new();
  final TextEditingController _nameController = .new();

  final TextEditingController _passwordController = .new();


  bool _isLogging = false;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final provider = Provider.of<AuthenticationProvider>(context);
    return ScreenWithBgLogo(
      child: Padding(
        padding: const .symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(localization.createAccount, style: AppTextStyles.headingTextStyle),
            Text(localization.createAccountDescription, style: AppTextStyles.subHeadingTextStyle, textAlign: .center,),
            Expanded(
              child: SingleChildScrollView(
                padding: .only(top: 16),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 16,
                  children: [
                    Align(
                      alignment: .center,
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
                                  // backgroundImage: AssetImage(AppIcons.icSplashLogo),
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
                                child: Icon(Icons.edit, color: Colors.white, size: 18,),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppTextField(title: localization.name, controller: _nameController, hintText: localization.name,),
                    AppTextField(title: localization.email, controller: _emailController, hintText: localization.email,textInputType: TextInputType.emailAddress,),
                    AppTextField(title: localization.password, controller: _passwordController, hintText: localization.password, isPassword: true,),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(
                  onTap: (){
                    context.push(NamedRoutes.completeProfile.routeName);
                  }, btnText: localization.createAccount, isLoading: _isLogging,),
            ),
            RichText(text: TextSpan(
                text: localization.alreadyHaveAnAccount,
                style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily),
                children: [
                  TextSpan(
                      text: localization.login,
                      recognizer: TapGestureRecognizer()..onTap = ()=> context.go(NamedRoutes.login.routeName),
                      style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily, fontWeight: .w600)
                  )
                ]
            ))
          ],
        ),
      ),
    );
  }
}
