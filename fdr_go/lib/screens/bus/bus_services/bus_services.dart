import 'package:fdr_go/data/route.dart';
import 'package:fdr_go/data/bus_service.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/screens/bus/absence/absenseWidget.dart';
import 'package:fdr_go/screens/bus/service_application/service_application.dart';
import 'package:fdr_go/screens/bus/terms_and_conditions/terms_and_conditions.dart';
import 'package:fdr_go/services/bus_service_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/line_dashed_painter.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';

class BusServicesPage extends StatefulWidget {
  final List<BusService> services;

  const BusServicesPage({this.services});

  @override
  State<StatefulWidget> createState() => _BusServicesPageState();
}

class _BusServicesPageState extends State<BusServicesPage> {
  bool _loading = false;
  List<String> goSteps = ["Paradero", "En Camino", "Colegio"];
  List<String> returnSteps = ["Colegio", "En Camino", "Paradero"];
  List<BusService> _services;

  @override
  void initState() {
    super.initState();
    _services = widget.services;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _loading ? _buildProgressBarWidget() : Container(),
        Container(
          margin: EdgeInsets.all(10.0),
          child: new RefreshIndicator(
            child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return _buildServicesListItem(index);
              },
            ),
            onRefresh: () {
              return getBusServices().then((response) {
                setState(() {
                  _services = response.services;
                });
              });
            },
          ),
        ),
      ],
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

  Widget _buildServicesListItem(int index) {
    BusService service = _services[index];
    Color textColor = service.isAbsence ? Colors.white : Colors.black;
    int id = service.id;
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        color: service.isAbsence ? primarySwatch['red'] : Colors.white,
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
                    _services[index].student.name +
                        ' ' +
                        _services[index].student.lastName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: textColor,
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
                "Grado: " + _services[index].student.grade,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              service.status == enumName(BusServiceStatus.AC) && !service.isAbsence
                  ? _buildServiceWidget(service)
                  : Container(),
              service.isAbsence
                  ? _buildAbsenceWidget(service)
                  : _buildActionButton(service, index),
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
      if (service.status == enumName(BusServiceStatus.PR)) {
        return _buildInProcessButton(index);
      } else if (service.status == enumName(BusServiceStatus.PC)) {
        return _buildConfirmTermsButton(index);
      } else {
        return _buildInProcessButton2(index);
      }
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
        onPressed: () => _openApplicationServicePage(_services[index].student),
        child: Text(
          "Solicitar Bus",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildInProcessButton(int index) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['blueDisabled'],
        textColor: Colors.white,
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        onPressed: null,
        //() => _openTermsAndConditions(services[index].student),
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
        onPressed: () => _openAbsencePage(_services[index].student),
        child: Text(
          "Inasistencia",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  _openApplicationServicePage(Student student) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ServiceApplicationPage(student: student),
      ),
    );

    if (refresh != null && refresh) {
      _refreshData(true);
    }
  }

  _openAbsencePage(Student student) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AbsencePage(student: student),
      ),
    );

    if (refresh != null && refresh) {
      _refreshData(true);
    }
  }

  Future<void> _refreshData(bool showLoading) {
    if (showLoading) {
      setState(() {
        _loading = true;
      });
    }
    getBusServices().then((servicesResponse) {
      _services = servicesResponse.services;
      setState(() {
        _loading = false;
      });
    });
    return null;
  }

  _openTermsAndConditions(BusService service) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TermsPage(service: service),
      ),
    );

    if (refresh != null && refresh) {
      _refreshData(false);
    }
  }

  Widget _buildAbsenceWidget(BusService service) {
    var dateFrom = service.absences.first.dateFrom;
    var dateTo = service.absences.first.dateTo;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.do_not_disturb_alt,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Inasistencia",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0,
                ),
                child: Text(
                  '$dateFrom - $dateTo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildConfirmTermsButton(index) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['blue'],
        textColor: Colors.white,
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        onPressed: () => _openTermsAndConditions(_services[index]),
        child: Text(
          "Confirmar",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  _buildInProcessButton2(index) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['blueDisabled'],
        textColor: Colors.white,
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        onPressed: null,
        child: Text(
          "En Proceso (2)",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildServiceWidget(BusService service) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 30.0,
                  right: 10.0,
                ),
                child: Icon(
                  Icons.directions_bus,
                  color: primarySwatch['red'],
                ),
              ),
              Text(
                service.statusDescription,
                style: TextStyle(
                  color: primarySwatch['red'],
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 30.0,
                  right: 10.0,
                ),
                child: Icon(
                  Icons.location_on,
                  color: primarySwatch['red'],
                ),
              ),
              Expanded(
                child: Text(
                  service.student.address,
                  style: TextStyle(
                    color: primarySwatch['red'],
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildStudentLocationWidget(service),
        ],
      ),
    );
  }

  Widget _buildStudentLocationWidget(BusService service) {
    double width = 250;
    double routeStateSize = 24;
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      width = 200;
      routeStateSize = 20;
    }
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
        left: routeStateSize,
        right: routeStateSize,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: routeStateSize / 2,
              right: routeStateSize / 2,
              left: routeStateSize / 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: width / 2,
                  child: CustomPaint(
                    painter: LineDashedPainter(color: primarySwatch['blue']),
                  ),
                ),
                Container(
                  width: width / 2,
                  child: CustomPaint(
                    painter: LineDashedPainter(
                        color: primarySwatch[service.locationStatus ==
                                enumName(LocationStatus.GO)
                            ? 'serviceStateBorder'
                            : 'blue']),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      right: routeStateSize / 2,
                      left: routeStateSize / 2,
                    ),
                    width: routeStateSize,
                    height: routeStateSize,
                    decoration: new BoxDecoration(
                      color: primarySwatch['blue'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: routeStateSize / 2,
                      left: routeStateSize / 2,
                    ),
                    width: routeStateSize,
                    height: routeStateSize,
                    decoration: new BoxDecoration(
                      color: primarySwatch[
                          service.locationStatus == enumName(LocationStatus.GO)
                              ? 'red'
                              : 'blue'],
                      shape: BoxShape.circle,
                    ),
                    child: service.locationStatus == enumName(LocationStatus.SC)
                        ? Icon(
                            Icons.check,
                            size: 15.0,
                            color: Colors.white,
                          )
                        : Container(),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      right: routeStateSize / 2,
                      left: routeStateSize / 2,
                    ),
                    width: routeStateSize,
                    height: routeStateSize,
                    decoration: new BoxDecoration(
                      color:
                          service.locationStatus == enumName(LocationStatus.GO)
                              ? Colors.white
                              : primarySwatch['red'],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primarySwatch[service.locationStatus ==
                                enumName(LocationStatus.GO)
                            ? 'serviceStateBorder'
                            : 'red'],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        goSteps[service.route.typeTrip == enumName(RouteType.I)
                            ? 0
                            : 2],
                        style: TextStyle(
                          color: primarySwatch['blue'],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        goSteps[1],
                        style: TextStyle(
                          color: primarySwatch[service.locationStatus ==
                                  enumName(LocationStatus.GO)
                              ? 'red'
                              : 'blue'],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        goSteps[service.route.typeTrip == enumName(RouteType.I)
                            ? 2
                            : 0],
                        style: TextStyle(
                          color: primarySwatch[service.locationStatus ==
                                  enumName(LocationStatus.GO)
                              ? 'serviceStateBorder'
                              : 'red'],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
