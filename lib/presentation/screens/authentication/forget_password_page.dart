import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/common_ui.dart';
import 'package:portalixmx_app/core/helpers/auth_error_localizer.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../core/res/app_textstyles.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key,});
  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              Text(localization.forgetPassword, style: AppTextStyles.headingTextStyle),
              const SizedBox(height: 16,),
              AppTextField(
                controller: _emailController,
                title: localization.email,
                hintText: localization.email,
                textInputType: TextInputType.emailAddress,
                validator: Validators.validateEmail(localization),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: PrimaryBtn(
                  onTap: _onForgetPasswordClick,
                  btnText: localization.submit,
                  isLoading: _isLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onForgetPasswordClick() async{
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      if (!mounted) return;
      CommonUI.showSnackBarMessage(context, isSuccess: true, message: AppLocalizations.of(context)!.resetPasswordLinkSent);
      Navigator.pop(context);
    } on FirebaseAuthException catch(e){
      if (!mounted) return;
      CommonUI.showSnackBarMessage(context, isError: true, message: AuthErrorLocalizer.localize(AppLocalizations.of(context)!, e.code));
    } catch(_){
      if (!mounted) return;
      CommonUI.showSnackBarMessage(context, isError: true, message: AppLocalizations.of(context)!.authUnknownError);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
