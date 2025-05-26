import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/authentication/otp_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text("Resident Login", style: AppTextStyles.headingTextStyle),
            const SizedBox(height: 16,),
            AppTextField(textController: _emailController, hintText: "Email",textInputType: TextInputType.emailAddress,),
            AppTextField(textController: _passwordController, hintText: "Password", isPassword: true,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onLoginTap, btnText: "Log in"),
            ),
            TextButton(onPressed: (){

            }, child: Text("Forgot your password", style: AppTextStyles.btnTextStyle,))
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

    final authRepo = AuthRepository();
    Map<String,dynamic>? map =  await authRepo.loginUser(email: email, password: password);
    if(map !=  null){
      String token = map['token'];
      String userID = map['userId'];
      String name = map['name'];

      final provider = Provider.of<UserViewModel>(context,listen: false);
      provider.setUserInfo(token: token, name: name, userID: userID, email: email);

     Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VerifyOTPPage(token: token)));
    }
  }
}
