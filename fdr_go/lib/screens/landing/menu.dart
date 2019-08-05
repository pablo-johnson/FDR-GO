import 'package:fdr_go/data/notification_menu.dart';
import 'package:fdr_go/data/requests/create_account_request.dart';
import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/screens/notifications/notifications.dart';
import 'package:fdr_go/screens/sign_in/sign_in.dart';
import 'package:fdr_go/services/account_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing.dart';

class MenuWidget extends StatefulWidget {
  final NotificationMenu notificationMenu;

  const MenuWidget({@required this.notificationMenu})
      : assert(notificationMenu != null);

  @override
  State<StatefulWidget> createState() => _MenuWidgetPageState();
}

class _MenuWidgetPageState extends State<MenuWidget> {
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    _getPersonalData().then((dynamic) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    int notificationsNumber = widget.notificationMenu.notifications;
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(userName),
                accountEmail: Text(userEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    getShortName(userName),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              _buildBusServiceOption(context),
              Container(
                height: 1.0,
                color: primarySwatch['dividerColor'],
                child: Divider(),
              ),
              _buildNotificationsOption(context, notificationsNumber),
              Container(
                height: 1.0,
                color: primarySwatch['dividerColor'],
                child: Divider(),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            height: 1.0,
            color: primarySwatch['dividerColor'],
            child: Divider(),
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: primarySwatch['red'],
            ),
            title: Align(
              child: Text(FdrLocalizations.of(context).menuLogOut),
              alignment: Alignment.centerLeft,
            ),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsOption(
      BuildContext context, int notificationsNumber) {
    return ListTile(
      leading: Icon(
        Icons.notifications,
        color: primarySwatch['blue'],
      ),
      title: Align(
        child: new Text(FdrLocalizations.of(context).menuNotifications),
        alignment: Alignment.centerLeft,
      ),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Visibility(
            visible: notificationsNumber > 0,
            child: Container(
              height: 30.0,
              width: 30.0,
              margin: EdgeInsets.only(right: 5.0),
              decoration: new BoxDecoration(
                  color: primarySwatch['red'],
                  borderRadius: new BorderRadius.all(Radius.circular(30.0))),
              child: new Center(
                child: new Text(
                  notificationsNumber.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: primarySwatch['blue'],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => NotificationsPage()));
      },
    );
  }

  Widget _buildBusServiceOption(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.directions_bus,
        color: primarySwatch['blue'],
      ),
      title: Align(
        child: new Text(FdrLocalizations.of(context).menuStudents),
        alignment: Alignment.centerLeft,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: primarySwatch['blue'],
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LandingPage()));
      },
    );
  }

  Future _getPersonalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("userName");
    userEmail = prefs.getString("userEmail");
  }

  Future _logout() async {
//    setState(() {
//      _loading = true;
//    });
    var request = new CreateAccountRequest();
    request.appId = Consts.appId;
    request.username = userEmail;
    logout(request).then((logoutResponse) {
//      setState(() {
//      _loading = false;
//      });
      _deleteCache();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInPage()));
    });
  }

  Future _deleteCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
