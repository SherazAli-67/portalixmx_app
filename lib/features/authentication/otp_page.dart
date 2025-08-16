import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/main_menu/resident_admin_main_menu.dart';
import 'package:portalixmx_app/features/main_menu/resident_main_menu_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/repositories/auth_repo.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key,});
  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {

  final TextEditingController _otpController = TextEditingController();
  final _authRepo = AuthRepository();
  bool _isVerifyingOtp = false;
  @override
  Widget build(BuildContext context) {
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(AppLocalizations.of(context)!.twoStepVerification, style: AppTextStyles.headingTextStyle),
            Text(AppLocalizations.of(context)!.twoStepVerificationDescription,textAlign: TextAlign.center, style: AppTextStyles.subHeadingTextStyle,),
            const SizedBox(height: 16,),
            AppTextField(textController: _otpController, hintText: AppLocalizations.of(context)!.otp, textInputType: TextInputType.number,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onVerifyOTPTap, btnText: AppLocalizations.of(context)!.submit, isLoading: _isVerifyingOtp,),
            ),
            TextButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.needHelp, style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }

  void _onVerifyOTPTap() async{
    String otp = _otpController.text.trim();
    try{
      if(otp.isEmpty){
        return;
      }
      final provider = Provider.of<UserInfoProvider>(context,listen: false);

      setState(() =>  _isVerifyingOtp = true);
      await _authRepo.verifyOTP(otp: otp,);
      setState(() =>  _isVerifyingOtp = false);
      provider.setLogin(true);
      if(provider.isResidentAdmin){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> ResidentAdminMainMenuPage()), (val)=> false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> ResidentMainMenuPage()), (val)=> false);
      }

    }catch(e){
      setState(() =>  _isVerifyingOtp = false);
      debugPrint("Error while verifying OTP: ${e.toString()}");
    }

  }
}
