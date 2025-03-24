import 'package:flutter/material.dart';
//import 'package:movecare/screens/camera_screen.dart';
//import 'package:movecare/screens/home_screen.dart';
import 'package:movecare/screens/splash_screen.dart';


void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
      //HomeScreen(),
      //CameraScreen(),
      //HomeScreen(),
      SplashScreen(),
  
    

    );
    }
    }
    