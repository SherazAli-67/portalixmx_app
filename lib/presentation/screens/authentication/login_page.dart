import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portalixmx_app/core/common_ui.dart';
import 'package:portalixmx_app/core/helpers/auth_error_localizer.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/authentication_provider/authentication_provider.dart';
import 'package:portalixmx_app/providers/home_provider.dart';
import 'package:portalixmx_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/res/app_constants.dart';
import '../../../core/res/app_textstyles.dart';
import '../../../router/app_router.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              Text(localization.residentLogin, style: AppTextStyles.headingTextStyle),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      AppTextField(
                        title: localization.email,
                        controller: _emailController,
                        hintText: localization.email,
                        textInputType: TextInputType.emailAddress,
                        validator: Validators.validateEmail(localization),
                      ),
                      AppTextField(
                        title: localization.password,
                        controller: _passwordController,
                        hintText: localization.password,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return localization.passwordRequired;
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(onPressed: ()=> context.push(NamedRoutes.forgetPassword.routeName), child: Text(localization.forgetPassword, style: AppTextStyles.btnTextStyle,)),
                      ),
                    ],
                  ),
                ),
              ),

              Consumer<AuthenticationProvider>(
                builder: (ctx, provider, child){
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryBtn(onTap: _onLoginTap, btnText: localization.login, isLoading: provider.isSigningIn,),);
                },
              ),
              RichText(text: TextSpan(
                text: localization.dontHaveAnAccount,
                style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily),
                children: [
                  TextSpan(
                    text: localization.createAccount,
                    recognizer: TapGestureRecognizer()..onTap = ()=> context.go(NamedRoutes.createAccount.routeName),
                    style: AppTextStyles.subHeadingTextStyle.copyWith(fontFamily: AppConstants.appFontFamily, fontWeight: FontWeight.w600)
                  )
                ]
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _onLoginTap()async{
    if (!(_formKey.currentState?.validate() ?? false)) return;
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final authProvider = context.read<AuthenticationProvider>();
    final profileProvider = context.read<ProfileProvider>();
    final homeProvider = context.read<HomeProvider>();
    String? result = await authProvider.onSignInTap(email: email, password: password);
    if (!mounted) return;
    if(result != null){
      CommonUI.showSnackBarMessage(context, isError: true, message: AuthErrorLocalizer.localize(AppLocalizations.of(context)!, result));
    }else{
      await profileProvider.reloadProfile();
      await homeProvider.reloadForCurrentUser();
      if (!mounted) return;
      context.go(NamedRoutes.home.routeName);
    }
  }
}
