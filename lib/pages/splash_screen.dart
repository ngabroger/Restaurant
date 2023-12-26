import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreeState createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreen();
  }

  splashScreen() {
    return Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/laphonte.png",
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
