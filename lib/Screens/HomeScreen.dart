import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Components/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> onTap(BuildContext context) async {
    await context.read<FlutterSecureStorage>().delete(key: 'userInfo');
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              const Text(
                "Logout",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              MyButton(
                  onPressed: () => onTap(context),
                  text: "Logout",
                  type: MyButtonType.submit),
            ],
          ),
        ));
  }
}
