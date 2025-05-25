import 'package:flutter/material.dart';
import 'package:portalixmx_app/features/authentication/otp_page.dart';
import 'package:portalixmx_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_app/repositories/auth_repo.dart';
import 'package:portalixmx_app/res/app_textstyles.dart';
import 'package:portalixmx_app/widgets/app_textfield_widget.dart';
import 'package:portalixmx_app/widgets/bg_logo_screen.dart';
import 'package:portalixmx_app/widgets/primary_btn.dart';

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
            AppTextField(textController: _emailController, hintText: "Email",),
            AppTextField(textController: _passwordController, hintText: "Password", isPassword: true,),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: (){
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if(email.isEmpty || password.isEmpty){
                  return;
                }

                final authRepo = AuthRepository();
                authRepo.loginUser(email: email, password: password);
              }, btnText: "Log in"),
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> OtpPage()));
            }, child: Text("Forgot your password", style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }
}
