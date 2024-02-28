import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  void registerUser() {
    String userID = userIDController.text;
    String password = passwordController.text;
    String email = emailController.text;
    String phoneNumber = phoneNumberController.text;

    bool inputIsValid = validateInputs(userID, password, email, phoneNumber);

    if (inputIsValid) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You have successfully registered.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Clear the text fields
                  userIDController.clear();
                  passwordController.clear();
                  emailController.clear();
                  phoneNumberController.clear();
                  // Navigate back to the login page
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool validateInputs(
      String userID, String password, String email, String phoneNumber) {
    bool isValid = true;

    bool inputsIsEmpty = userID.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty;
    bool hasUpppercase = RegExp(r'[a-z]+').hasMatch(password);
    bool hasLowercase = RegExp(r'[A-Z]+').hasMatch(password);
    bool hasNumber = RegExp(r'[0-9]+').hasMatch(password);
    const minLength = 8;

    isValid = hasUpppercase &&
        hasLowercase &&
        hasNumber &&
        (password.length >= minLength);

    if (!isValid) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "• Has at least one Uppercase",
                      style: TextStyle(
                          color: hasUpppercase ? Colors.green : Colors.red),
                    ),
                    Text(
                      "• Has at least one Lowercase",
                      style: TextStyle(
                          color: hasLowercase ? Colors.green : Colors.red),
                    ),
                    Text(
                      "• Has at least one number",
                      style: TextStyle(
                          color: hasNumber ? Colors.green : Colors.red),
                    ),
                    Text(
                      "• Password must be longer than 8 characters",
                      style: TextStyle(
                          color: (password.length >= minLength)
                              ? Colors.green
                              : Colors.red),
                    )
                  ],
                ),
              ),
            );
          });
      return false;
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: userIDController,
              decoration: InputDecoration(
                labelText: 'User ID',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            Container(
              margin: EdgeInsets.only(top: 50.0), // Add margin top here
              child: GestureDetector(
                onTap: registerUser,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
