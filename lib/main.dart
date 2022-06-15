import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/registration_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Email And Password Login",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: LoginScreen(),
      routes: {
        RegistrationScreen.routeName:(context) => const RegistrationScreen(),
        HomeScreen.routeName:(context) => const HomeScreen(),
      },
    );
  }
}