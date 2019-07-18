import 'package:fdr_go/screens/sign_in/sign_in.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuWidget extends StatefulWidget {
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
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? primarySwatch['blue']
                          : Colors.white,
                  child: Text(
                    getShortName(userName),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.notifications,
                  color: primarySwatch['blue'],
                ),
                title: Align(
                  child: new Text("Notificaciones"),
                  alignment: Alignment.centerLeft,
                ),
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      width: 30.0,
                      margin: EdgeInsets.only(right: 5.0),
                      decoration: new BoxDecoration(
                          color: primarySwatch['blue'],
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30.0))),
                      child: new Center(
                        child: new Text(
                          "5",
                          style: TextStyle(color: Colors.white),
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
                  Navigator.pop(context);
                },
              ),
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
              child: new Text("Cerrar Sesión"),
              alignment: Alignment.centerLeft,
            ),
            onTap: () {
              _logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future _getPersonalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("userName");
    userEmail = prefs.getString("userEmail");
  }

  Future _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
  }
}
