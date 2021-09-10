import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsappshortlink/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    splash();
    super.initState();
  }

  splash() {
    return Timer(Duration(seconds: 1), () {
      print("splash");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff5BCF67),
                Color(0xff1FAE37),
              ]),
        ),
        child: Center(
          child: Image.asset(
            'waquick.png',
            width: MediaQuery.of(context).size.width - 50,
          ),
        ),
      ),
    );
  }
}
