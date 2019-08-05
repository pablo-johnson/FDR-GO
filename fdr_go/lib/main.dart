import 'package:fdr_go/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lang/fdr_localizations_delegate.dart';
import 'util/colors.dart';

void main() => runApp(MyApp());
//void main() {
//  runApp(
//    MaterialApp(
//      home: PushMessagingExample(),
//    ),
//  );
//}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  String languageCode = "en";
  String countryCode = "US";

  @override
  void initState() {
    super.initState();
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      languageCode = value.getString("languageCode");
      if (languageCode == null || languageCode.isEmpty) {
        value.setString("languageCode", "en");
      }
      countryCode = value.getString("countryCode");
      new FdrLocalizationsDelegate().load(Locale(languageCode, countryCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        const FdrLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('es', 'ES'), // Spanish
        // ... other locales the app supports
      ],
      locale: Locale(languageCode, countryCode),
      title: 'FDR GO',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF002664, primaryColorMap),
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
