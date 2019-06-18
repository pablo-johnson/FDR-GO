import 'package:fdr_go/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:fdr_go/util/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF002664, primaryColorMap),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
