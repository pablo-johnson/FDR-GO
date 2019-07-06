import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/data/service.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/screens/absence/absenseWidget.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:flutter/material.dart';

import 'menu.dart';

class LandingPage extends StatefulWidget {
  final LoginResponse loginResponse;

  const LandingPage({@required this.loginResponse})
      : assert(loginResponse != null);

  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Alumnos"),
      ),
      drawer: new MenuWidget(),
      backgroundColor: primarySwatch['blue'],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: widget.loginResponse.services.length,
          itemBuilder: (context, index) {
            return _buildServicesListItem(index);
          },
        ),
      ),
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
    });
  }

  Widget _buildServicesListItem(int index) {
    Service service = widget.loginResponse.services[index];
    int id = service.id;
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        color: Colors.white,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Material(
                color: Colors.transparent,
                child: Hero(
                  tag: "hero$id",
                  child: Text(
                    widget.loginResponse.services[index].student.name +
                        ' ' +
                        widget.loginResponse.services[index].student.lastName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Grado: " + widget.loginResponse.services[index].student.grade,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              service.route == null
                  ? _buildAskServiceButton(index)
                  : _buildAskAbsenceButton(index),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildAskServiceButton(int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['blue'],
        textColor: Colors.white,
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        splashColor: primarySwatch['bluePressed'],
        onPressed: () =>
            _openAbsencePage(widget.loginResponse.services[index].student),
        child: Text(
          "Solicitar Bus",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  _openAbsencePage(Student student) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AbsencePage(student: student)));
  }

  Widget _buildAskAbsenceButton(int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['red'],
        textColor: Colors.white,
        disabledColor: primarySwatch['redDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        splashColor: primarySwatch['redPressed'],
        onPressed: () =>
            _openAbsencePage(widget.loginResponse.services[index].student),
        child: Text(
          "Inasistencia",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
