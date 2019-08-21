import 'package:after_layout/after_layout.dart';
import 'package:fdr_go/data/bus_service.dart';
import 'package:fdr_go/data/notification_menu.dart';
import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/screens/asa/services/asa_services.dart';
import 'package:fdr_go/screens/bus/services/bus_services.dart';
import 'package:fdr_go/screens/notifications/notifications.dart';
import 'package:fdr_go/services/account_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'menu.dart';

class LandingPage extends StatefulWidget {
  final LoginResponse loginResponse;

  const LandingPage({this.loginResponse});

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with AfterLayoutMixin<LandingPage> {
  static const int BUS_SERVICE = 0;
  static const int ASA_SERVICE = 1;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var _selectedIndex = BUS_SERVICE;
  List<BusService> services;
  String _title = "";

  NotificationMenu notificationMenu;

  @override
  void initState() {
    super.initState();
    _setUpFcm();
    _setUpLocalNotifications();
    if (widget.loginResponse != null) {
      services = widget.loginResponse.services;
    }
  }

  @override
  Widget build(BuildContext context) {
    notificationMenu = new NotificationMenu();
    notificationMenu.notifications = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text(_title),
      ),
      drawer: new MenuWidget(
        notificationMenu: notificationMenu,
      ),
      backgroundColor: primarySwatch['blue'],
      body: _selectedIndex == BUS_SERVICE
          ? new BusServicesPage(services: services)
          : new AsaServicesPage(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus),
          title: Text('BUS'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity),
          title: Text('ASA'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: primarySwatch['red'],
      unselectedItemColor: Colors.black,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedIndex == BUS_SERVICE
          ? _title = FdrLocalizations.of(context).landingBusTitle
          : _title = FdrLocalizations.of(context).landingAsaTitle;
    });
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _title = FdrLocalizations.of(context).landingBusTitle;
    setState(() {});
  }

  void _setUpFcm() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToNotifications();
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      sendToken(token);
      print("Push Messaging token: $token");
    });
  }

  void _setUpLocalNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> _showNotification(Map<String, dynamic> notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, notification["notification"]["title"],
        notification["notification"]["body"], platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    _navigateToNotifications();
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              _navigateToNotifications();
            },
          )
        ],
      ),
    );
  }

  void _navigateToNotifications() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NotificationsPage()));
  }
}
