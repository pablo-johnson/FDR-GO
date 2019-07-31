import 'package:fdr_go/data/activity.dart';
import 'package:fdr_go/data/asa_service.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/screens/asa/service_application/service_application.dart';
import 'package:fdr_go/services/asa_service_services.dart';
import 'package:fdr_go/util/ToastUtil.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';

class AsaServicesPage extends StatefulWidget {
  final List<AsaService> services;

  const AsaServicesPage({this.services});

  @override
  State<StatefulWidget> createState() => _AsaServicesPageState();
}

class _AsaServicesPageState extends State<AsaServicesPage> {
  bool _loading = true;
  List<AsaService> _services = new List();

  @override
  void initState() {
    super.initState();
    if (widget.services == null) {
      _refreshData(false);
    } else {
      _services = widget.services;
    }
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
                return _buildAsaServicesListItem(index);
              },
            ),
            onRefresh: () {
              return getAsaServices().then((response) {
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

  Widget _buildAsaServicesListItem(int index) {
    AsaService service = _services[index];
    Color textColor = Colors.black;
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
              _buildActionButton(service, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(AsaService service, index) {
    if (service.serviceStatus == null) {
      return Container();
    } else if (service.serviceStatus == enumName(AsaServiceStatus.IN)) {
      return _buildAskServiceButton(index);
    } else if (service.serviceStatus == enumName(AsaServiceStatus.PR)) {
      return _buildInProcessButton(index);
    } else if (service.serviceStatus == enumName(AsaServiceStatus.ER)) {
      return _services[index].activities.length > 0
          ? _buildChangeAsaServiceWidget(index)
          : Container();
    } else {
      return _buildAsaServicesInformationWidget(index);
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
          "Inscribir",
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

  Widget _buildChangeAsaServiceWidget(index) {
    List<Activity> _activities = _services[index].activities;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: _activities.length > 0,
          child: _buildAsaServiceInformationWidget(index, _activities[0]),
        ),
//        Visibility(
//          visible: _activities.length > 0,
//          child: _buildChangeAsaServiceButton(index, _activities[0]),
//        ),
        SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: _activities.length > 1,
          child: _buildAsaServiceInformationWidget(index, _activities[1]),
        ),
//        Visibility(
//          visible: _activities.length > 1,
//          child: _buildChangeAsaServiceButton(index, _activities[1]),
//        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _buildAsaServicesInformationWidget(index) {
    List<Activity> _activities = _services[index].activities;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: _activities.length > 0,
          child: _buildAsaServiceInformationWidget(index, _activities[0]),
        ),
        SizedBox(
          height: 10.0,
        ),
        Visibility(
          visible: _activities.length > 1,
          child: _buildAsaServiceInformationWidget(index, _activities[1]),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget _buildAsaServiceInformationWidget(index, Activity activity) {
    String frequency = activity.frequency;
    String startDate = activity.startTime;
    String endDate = activity.endTime;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          activity.description,
          style: TextStyle(
            color: primarySwatch['red'],
            fontSize: 18.0,
          ),
        ),
        Text(
          '$frequency $startDate - $endDate',
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
          ),
        )
      ],
    );
  }

  Widget _buildChangeAsaServiceButton(int index, Activity activity) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        color: primarySwatch['red'],
        textColor: Colors.white,
        disabledColor: primarySwatch['redDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        splashColor: primarySwatch['redPressed'],
        onPressed: () => _openChangeAsaServicePage(_services[index].student),
        child: Text(
          "Cambiar",
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
        builder: (context) => AsaServiceApplicationPage(
          student: student,
          frequency: AsaServiceApplicationPage.LUN_JUE_FREQ,
        ),
      ),
    );

    if (refresh != null && refresh) {
      _refreshData(true);
      showSuccessToast("Actividades ASA guardadas exitosamente");
    }
  }

  Future<void> _refreshData(bool showLoading) {
    if (showLoading) {
      setState(() {
        _loading = true;
      });
    }
    getAsaServices().then((servicesResponse) {
      _services = servicesResponse.services;
      setState(() {
        _loading = false;
      });
    });
    return null;
  }

  _openChangeAsaServicePage(Student student) {}
}
