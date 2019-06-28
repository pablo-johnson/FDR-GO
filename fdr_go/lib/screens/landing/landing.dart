import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final LoginResponse loginResponse;

  const LandingPage({@required this.loginResponse})
      : assert(loginResponse != null);

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
      backgroundColor: primarySwatch['blue'],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: widget.loginResponse.families[0].students.length,
          itemBuilder: (context, index) {
            return buildStudentsList(index);
          },
        ),
      ),
    );
  }

  Widget buildStudentsList(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        color: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  widget.loginResponse.families[0].students[index].name +
                      ' ' +
                      widget.loginResponse.families[0].students[index].lastName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Grado: " +
                      widget.loginResponse.families[0].students[index].grade,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: primarySwatch['blue'],
                  textColor: Colors.white,
                  disabledColor: primarySwatch['blueDisabled'],
                  disabledTextColor: primarySwatch['whiteDisabled'],
                  splashColor: primarySwatch['bluePressed'],
                  onPressed: () => null,
                  child: Text(
                    "Solicitar Bus",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: Text(widget.loginResponse.name),
            accountEmail: Text(widget.loginResponse.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? primarySwatch['blue']
                  : Colors.white,
              child: Text(
                getShortName(widget.loginResponse.name),
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
//          ListTile(
//            title: Text(
//              "Item 2",
//            ),
//            trailing: Icon(
//              Icons.arrow_forward_ios,
//              color: primarySwatch['blue'],
//            ),
//            onTap: () {
//              Navigator.pop(context);
//            },
//          ),
        ],
      ),
    );
  }
}
