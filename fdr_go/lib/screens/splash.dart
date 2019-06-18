import 'dart:async';

import 'package:fdr_go/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignInPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage('assets/images/splash_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset(
              "assets/images/splash_logo.png",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
