import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/authentication/otp_page.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import 'package:portalixmx_app/providers/user_info_provider.dart';
import 'package:portalixmx_app/repositories/auth_repo.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLogging = false;
  @override
  Widget build(BuildContext context) {
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text(AppLocalizations.of(context)!.residentLogin, style: AppTextStyles.headingTextStyle),
            const SizedBox(height: 16,),
            AppTextField(textController: _emailController, hintText: AppLocalizations.of(context)!.email,textInputType: TextInputType.emailAddress,),
            AppTextField(textController: _passwordController, hintText: AppLocalizations.of(context)!.password, isPassword: true,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(

                  onTap: _onLoginTap, btnText: AppLocalizations.of(context)!.login, isLoading: _isLogging,),
            ),
            TextButton(onPressed: (){
            }, child: Text(AppLocalizations.of(context)!.forgetPassword, style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }

  void _onLoginTap()async{
    FocusManager.instance.primaryFocus?.unfocus();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if(email.isEmpty || password.isEmpty){
      return;
    }

    setState(()=> _isLogging = true);
    final authRepo = AuthRepository();

    try{
      Map<String,dynamic>? map =  await authRepo.loginUser(email: email, password: password);
      if(map !=  null){
        String token = map['token'];
        String userID = map['userId'];
        String name = map['name'];
        setState(()=> _isLogging = false);
        final provider = Provider.of<UserViewModel>(context,listen: false);
        provider.setUserInfo(token: token, name: name, userID: userID, email: email);

        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VerifyOTPPage()));
      }
    }catch(e){
      debugPrint("Error while login user: ${e.toString()}");
      setState(()=> _isLogging = false);
    }

  }
}
