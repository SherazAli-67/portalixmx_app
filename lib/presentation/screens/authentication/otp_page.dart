import 'package:flutter/material.dart';
import 'package:portalixmx_app/core/validators/validators.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../../core/res/app_textstyles.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';

class VerifyOTPPage extends StatefulWidget {
  const VerifyOTPPage({super.key,});
  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {

  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isVerifyingOtp = false;

  @override
  void dispose() {
    _otpController.dispose();
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
              Text(localization.twoStepVerification, style: AppTextStyles.headingTextStyle),
              Text(localization.twoStepVerificationDescription,textAlign: TextAlign.center, style: AppTextStyles.subHeadingTextStyle,),
              const SizedBox(height: 16,),
              AppTextField(
                controller: _otpController,
                hintText: localization.otp,
                textInputType: TextInputType.number,
                validator: Validators.validateOtp(localization),
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: PrimaryBtn(onTap: _onVerifyOTPTap, btnText: localization.submit, isLoading: _isVerifyingOtp,),
              ),
              TextButton(onPressed: (){}, child: Text(localization.needHelp, style: AppTextStyles.btnTextStyle,))
            ],
          ),
        ),
      ),
    );
  }

  void _onVerifyOTPTap() async{
    if (!(_formKey.currentState?.validate() ?? false)) return;
  }
}
