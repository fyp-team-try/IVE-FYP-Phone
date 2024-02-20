import 'package:flutter/material.dart';
import 'package:sampleproject/login_page.dart';
import 'package:sampleproject/register.dart';
import 'package:sampleproject/functionpage_widget.dart';
import 'package:sampleproject/functionpage_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
