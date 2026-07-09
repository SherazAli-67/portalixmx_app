import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/common_ui.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(AppLocalizations.of(context)!.forgetPassword, style: AppTextStyles.headingTextStyle),
            const SizedBox(height: 16,),
            AppTextField(controller: _emailController, title: AppLocalizations.of(context)!.email, hintText: AppLocalizations.of(context)!.email, textInputType: .emailAddress,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onForgetPasswordClick, btnText: AppLocalizations.of(context)!.submit,),
            ),
          ],
        ),
      ),
    );
  }


  void _onForgetPasswordClick() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      CommonUI.showSnackBarMessage(context, isSuccess: true, message: 'A reset password link is sent to your email address, you can update your password from there');
      Navigator.pop(context);
    }catch(e){
      CommonUI.showSnackBarMessage(context, isError: true, message: e.toString());
    }
  }
}
