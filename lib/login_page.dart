import 'package:flutter/material.dart';
import 'package:sampleproject/components/my_button.dart';
import 'package:sampleproject/components/my_textfield.dart';
import 'package:sampleproject/register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  //user login in method
  void userLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),

            //logo
            Image.asset(
              'lib/image/logo.png',
              height: 150, // set the desired height
              width: 150, // set the desired width
            ),

            const SizedBox(height: 50),

            //welcome message
            Text(
              'Welcome back!',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 25),

            //username textfield
            MyTextField(
              controller: usernameController,
              hintText: 'Username',
              obsureText: false,
            ),
            const SizedBox(height: 10),

            //password textfield
            MyTextField(
              controller: passwordController,
              hintText: 'Password',
              obsureText: true,
            ),
            const SizedBox(height: 10),

            //forget password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            //sign in button
            MyButton(
              onTap: userLogin,
            ),
            const SizedBox(height: 50),

            //not a member
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        )));
  }
}
