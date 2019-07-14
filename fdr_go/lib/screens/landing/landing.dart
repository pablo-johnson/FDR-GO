import 'package:fdr_go/data/responses/login_response.dart';
import 'package:fdr_go/data/service.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/screens/absence/absenseWidget.dart';
import 'package:fdr_go/screens/service_application/service_application.dart';
import 'package:fdr_go/services/service_services.dart';
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
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Alumnos"),
      ),
      drawer: new MenuWidget(),
      backgroundColor: primarySwatch['blue'],
      body: Stack(
        children: <Widget>[
          _loading ? _buildProgressBarWidget() : Container(),
          Container(
            margin: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: widget.loginResponse.services.length,
              itemBuilder: (context, index) {
                return _buildServicesListItem(index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Container _buildProgressBarWidget() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: primarySwatch['progressBackground'],
      child: Center(
        child: CircularProgressIndicator(),
      ),
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
              _buildActionButton(service, index),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildActionButton(service, index) {
    if (service.route == null && service.requestService == null) {
      return _buildAskServiceButton(index);
    } else if (service.requestService != null) {
      return _buildInProcessButton();
    } else {
      return _buildAskAbsenceButton(index);
    }
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
        onPressed: () => _openApplicationServicePage(
            widget.loginResponse.services[index].student),
        child: Text(
          "Solicitar Bus",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildInProcessButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['blueDisabled'],
        textColor: Colors.white,
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        onPressed: null,
        child: Text(
          "En Proceso",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
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

  _openApplicationServicePage(Student student) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceApplicationPage(
            parentName: widget.loginResponse.name, student: student),
      ),
    );

    if (refresh) {
      _refreshData();
    }
  }

  _openAbsencePage(Student student) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AbsencePage(student: student),
      ),
    );

    if (refresh) {
      _refreshData();
    }
  }

  void _refreshData() {
    setState(() {
      _loading = true;
    });
    getServices().then((servicesResponse) {
      widget.loginResponse.services = servicesResponse.services;
      setState(() {
        _loading = false;
      });
    });
  }
}
