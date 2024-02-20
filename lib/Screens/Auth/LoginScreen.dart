import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/button.dart';
import 'package:user_app/Components/textfield.dart';
import 'package:user_app/Models/Api/ApiRequestModels/AuthRequestModels.dart';
import 'package:user_app/Services/request/AuthRequest.dart';

import '../../Models/UserInfo.dart';
import '../../Providers/AuthProvider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void userLogin(BuildContext context) async {
    try {
      LoginRequestModels loginRequestModels = LoginRequestModels(
          username: usernameController.text, password: passwordController.text);
      UserInfo info = await LoginRequest(loginRequestModels, context);

      context.read<AuthProvider>().setUserInfo(info);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(info.token),
        duration: const Duration(seconds: 2),
      ));

      Navigator.pushNamed(context, '/home');
    } catch (e) {}
  }

  void userRegister(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Register'),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/images/logo.png', height: 150, width: 150),
              const SizedBox(height: 50),
              const Text(
                "Welcome",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              const SizedBox(height: 25),
              MyTextField(
                  controller: usernameController,
                  hintText: "Username",
                  obsureText: false),
              MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obsureText: true),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.grey[600]),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                  onPressed: () => userLogin(context),
                  text: "Login",
                  type: MyButtonType.submit),
              const SizedBox(height: 50),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 5),
                  MyButton(
                      onPressed: () => userRegister(context),
                      text: "Register",
                      type: MyButtonType.submit)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
