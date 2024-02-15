import 'package:flutter/material.dart';

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

    // Check if any of the fields are empty
    if (userID.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Exit the method if any field is empty
    }

    // Show a registration success message
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
            ElevatedButton(
              onPressed: registerUser,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
