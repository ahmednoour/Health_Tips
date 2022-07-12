import 'package:app_med/Get_Started.dart';
import 'package:app_med/Sign_Screen.dart';
import 'package:app_med/Welcome_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());



}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp
      (



      home: GetStartedScreen(),
      debugShowCheckedModeBanner: false,


    );
  }
}

