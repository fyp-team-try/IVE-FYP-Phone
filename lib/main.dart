import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Providers/AuthProvider.dart';

import 'Screens/Auth/LoginScreen.dart';
import 'Screens/HomeScreen.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  runApp(MultiProvider(providers: [
    Provider<FlutterSecureStorage>(
        create: (context) => const FlutterSecureStorage()),
    ProxyProvider<FlutterSecureStorage, AuthProvider>(
        update: (context, storage, previous) => AuthProvider(storage)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Smart Car Parking App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: context.read<AuthProvider>().init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: context.read<AuthProvider>().isLogined(),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return HomeScreen();
                  }
                  return LoginScreen();
                });
          } else {
            return const RefreshProgressIndicator();
          }
        },
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
