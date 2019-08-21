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

  Future<Locale> _getSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString("languageCode");
    if (languageCode == null || languageCode.isEmpty) {
      prefs.setString("languageCode", "en");
      languageCode = "en";
    }
    countryCode = prefs.getString("countryCode");
    if (countryCode == null || countryCode.isEmpty) {
      prefs.setString("countryCode", "US");
      countryCode = "US";
    }
    return Locale(languageCode, countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._getSavedLocale(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return CircularProgressIndicator();
          case ConnectionState.done:
          default:
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
              locale: snapshot.data,
              title: 'FDR GO',
              theme: ThemeData(
                primarySwatch: const MaterialColor(0xFF002664, primaryColorMap),
                fontFamily: 'Roboto',
              ),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
        }
      },
    );
  }
}
