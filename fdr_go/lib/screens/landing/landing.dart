import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage(LoginResponse loginResponse);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Alumnos"),
      ),
      drawer: buildDrawer(context),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text("Pablo Johnson"),
            accountEmail: Text("pablo.johnson@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? primarySwatch['blue']
                      : Colors.white,
              child: Text(
                "PJ",
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
              alignment: Alignment(-1.5, 0),
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
          ListTile(
            title: Text(
              "Item 2",
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: primarySwatch['blue'],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
