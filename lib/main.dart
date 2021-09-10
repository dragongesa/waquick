import 'package:flutter/material.dart';
import 'package:whatsappshortlink/screens/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quick Whatsapp without save the phone",
      home: SplashScreen(),
    );
  }
}
