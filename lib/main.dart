import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:user_app/Screens/Chat/ChatRoomWidget.dart';
import 'package:user_app/Screens/Chat/ChatWidget.dart';
import 'package:user_app/Providers/AuthProvider.dart';
import 'package:user_app/Screens/FunctionPage/FunctionPageWidget.dart';
import 'package:user_app/Screens/History/BookingHistoryWidget.dart';
import 'package:user_app/Screens/History/HistoryWidget.dart';
import 'package:user_app/Screens/History/BookingHistoryModWidget.dart';
import 'package:user_app/Screens/LocationPage/LocationDetailWidget.dart';
import 'package:user_app/Screens/LocationPage/searchLocationWidget.dart';
import 'package:user_app/Screens/Payment/paymentwidget.dart';
import 'package:user_app/Screens/Plan/planwidget.dart';
import 'package:user_app/Screens/Setting/AddCreditCardWidget.dart';
import 'package:user_app/Screens/Setting/AddVehicleWidget.dart';
import 'package:user_app/Screens/Setting/EditPasswordWidget.dart';
import 'package:user_app/Screens/Setting/EditProfileWidget.dart';
import 'package:user_app/Screens/Setting/ManageVehicleWidget.dart';
import 'package:user_app/Screens/Setting/PaymentOptionWidget.dart';
import 'package:user_app/Screens/Setting/SettingWidget.dart';
import 'package:user_app/Screens/register.dart';

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
                    return FunctionPageWidget();
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
        '/functions': (context) => FunctionPageWidget(),
        '/register': (context) => RegisterPage(),
        '/location': (context) => SearchLocationWidget(),
        '/locationDetail': (context) => LocationDetailWidget(),
        '/plan': (context) => PlanWidget(),
        '/payment':(context)=>PaymentWidget(),
        '/history':(context)=>HistoryWidget(),
        '/BookingHistory':(context)=>BookingHistoryWidget(),
        '/BookingModify':(context)=>HistoryModifybookingWidget(),
        '/Setting':(context)=>SettingWidget(),
        '/PaymentOption':(context)=>PaymentOptionsWidget(),
        '/EditPassword':(context)=>EditPasswordWidget(),
        '/EditProfile':(context)=>EditProfileWidget(),
        '/AddCreditCard':(context)=>AddCreditCardWidget(),
        '/AddVehicle':(context)=>AddVehicleWidget(),
        '/ManageVehicle':(context)=>ManageVehicleWidget(),
        '/Chat':(context)=>ChatPage(),
        '/ChatRooms':(context)=>ChatRoomWidget()
      },
    );
  }
}
