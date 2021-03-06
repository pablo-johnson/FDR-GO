import 'package:fdr_go/data/activity.dart';
import 'package:fdr_go/data/requests/save_activities_request.dart';
import 'package:fdr_go/data/responses/activities_response.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/data/transport_request_days.dart';
import 'package:fdr_go/lang/fdr_localizations.dart' as MyLocalization;
import 'package:fdr_go/services/asa_service_services.dart';
import 'package:fdr_go/util/ToastUtil.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';

class AsaServiceApplicationPage extends StatefulWidget {
  final Student student;
  final int frequency;

  static const LUN_JUE_FREQ = 1;
  static const MIE_VIEW_FREQ = 2;

  const AsaServiceApplicationPage(
      {@required this.student, @required this.frequency})
      : assert(student != null);

  @override
  State<StatefulWidget> createState() => _AsaServiceApplicationPageState();
}

class _AsaServiceApplicationPageState extends State<AsaServiceApplicationPage> {
  bool _loading = true;
  bool _isContinueButtonEnabled = false;
  bool _day1 = false;
  bool _day2 = false;
  bool _noBus = false;
  String _disclaimer = "";

  List<Activity> _activities = new List();
  TransportRequestDays _transportRequestDays;

  List<Activity> _selectedActivities = new List();

  @override
  void initState() {
    super.initState();
    _getActivities(widget.student);
  }

  void _getActivities(Student student) {
    getAsaActivities(student.id, widget.frequency).then((serviceModesResponse) {
      if (serviceModesResponse.success) {
        setState(() {
          _loading = false;
          _activities = serviceModesResponse.activities;
          _initSelectedActivities();
          _initTransportCheckboxes(serviceModesResponse);
          _disclaimer = serviceModesResponse.instructions;
          _enableContinueButton();
        });
      }
    });
  }

  void _initSelectedActivities() {
    for (Activity activity in _activities) {
      if (activity.priority > 0) {
        _selectedActivities.add(activity);
      }
    }
    _selectedActivities.sort((a, b) => a.priority < b.priority ? -1 : 1);
  }

  void _initTransportCheckboxes(ActivitiesResponse serviceModesResponse) {
    _day1 = widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
        ? serviceModesResponse.transportRequestDays.monday == "S"
        : serviceModesResponse.transportRequestDays.tuesday == "S";
    _day2 = widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
        ? serviceModesResponse.transportRequestDays.thursday == "S"
        : serviceModesResponse.transportRequestDays.friday == "S";
    _noBus = serviceModesResponse.transportRequestDays.none == "S";
    _transportRequestDays = serviceModesResponse.transportRequestDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primarySwatch['red'],
          title: Text(
            MyLocalization.FdrLocalizations.of(context).asaApplicationTitle,
          )),
      backgroundColor: Colors.white,
      body: _buildServiceApplicationWidget(widget.student),
    );
  }

  Widget _buildServiceApplicationWidget(Student student) {
    BoxDecoration boxDecoration = new BoxDecoration(
        color: primarySwatch['disabledTextFieldBackground'],
        border:
            new Border.all(color: primarySwatch['textFieldBorder'], width: 1.0),
        borderRadius: new BorderRadius.circular(4.0));

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            _buildMainForm(student, boxDecoration),
            Expanded(
              child: Container(
                child: _buildActivityList(),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
        _loading ? _buildProgressBarWidget() : Container(),
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

  Widget _buildMainForm(Student student, BoxDecoration boxDecoration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Material(
            color: Colors.transparent,
            child: Text(
              student.name + " " + student.lastName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            MyLocalization.FdrLocalizations.of(context)
                    .notificationDetailGrade +
                student.grade,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            _disclaimer,
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: double.infinity,
          color: primarySwatch['electricBlue'],
          padding: EdgeInsets.symmetric(
            vertical: 10.0,
          ),
          child: Center(
            child: Text(
              widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
                  ? MyLocalization.FdrLocalizations.of(context)
                      .mon_thur //"Lunes - Jueves"
                  : MyLocalization.FdrLocalizations.of(context)
                      .tue_fri, //"Martes - Viernes",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: primarySwatch['textFieldBorder'],
          padding: EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "BUS: ",
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                new Checkbox(
                  value: _day1,
                  onChanged: _day1Changed,
                ),
                Text(
                  widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
                      ? MyLocalization.FdrLocalizations.of(context).monday
                      : MyLocalization.FdrLocalizations.of(context).tuesday,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                new Checkbox(
                  value: _day2,
                  onChanged: _day2Changed,
                ),
                Text(
                  widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
                      ? MyLocalization.FdrLocalizations.of(context)
                          .thursday //"Jueves"
                      : MyLocalization.FdrLocalizations.of(context)
                          .friday, //"Viernes",
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                new Checkbox(
                  value: _noBus,
                  onChanged: _noBusChanged,
                ),
                Text(
                  "No Bus",
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (5 / 2),
      children: List.generate(_activities.length, (index) {
        return _buildGridItem(index);
      }),
    );
  }

  Widget _buildGridItem(int index) {
    Activity activity = _activities[index];
    int number = _selectedActivities.indexOf(activity);
    return GestureDetector(
      onTap: () {
        if (number < 0 && _selectedActivities.length < 3) {
          setState(() {
            _selectedActivities.add(activity);
            activity.selected = "S";
            _enableContinueButton();
          });
        } else if (number >= 0) {
          setState(() {
            _selectedActivities.remove(activity);
            activity.selected = "N";
            _enableContinueButton();
          });
        } else {
          showErrorToast("Máximo 3 actividades.");
        }
      },
      child: Container(
        decoration: new BoxDecoration(
          border: new Border.all(
            color: primarySwatch['notificationSeparator'],
            width: 0.5,
          ),
        ),
        height: 20.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Visibility(
                visible: number >= 0 || activity.selected == "S",
                child: Container(
                  color: number >= 0 || activity.selected == "S"
                      ? primarySwatch['electricBlue']
                      : Colors.white,
                  child: Center(
                    child: Text(
                      (number + 1).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(
                  5.0,
                ),
                color: number >= 0 || activity.selected == "S"
                    ? primarySwatch['electricBlue']
                    : primarySwatch['textFieldBorder'],
                child: Center(
                  child: Text(
                    activity.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: new SizedBox(
            height: Consts.commonButtonHeight,
            child: RaisedButton(
              textColor: Colors.white,
              color: primarySwatch['red'],
              disabledColor: primarySwatch['redDisabled'],
              disabledTextColor: primarySwatch['whiteDisabled'],
              child: Text(
                MyLocalization.FdrLocalizations.of(context)
                    .cancel
                    .toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading ? null : () => _dismiss(false),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: new SizedBox(
            height: Consts.commonButtonHeight,
            child: RaisedButton(
              textColor: Colors.white,
              color: primarySwatch['blue'],
              disabledColor: primarySwatch['blueDisabled'],
              disabledTextColor: primarySwatch['whiteDisabled'],
              child: Text(
                widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ
                    ? MyLocalization.FdrLocalizations.of(context)
                        .next
                        .toUpperCase()
                    : MyLocalization.FdrLocalizations.of(context)
                        .accept
                        .toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading || !_isContinueButtonEnabled
                  ? null
                  : () => _saveSelection(),
            ),
          ),
        ),
      ],
    );
  }

  void _enableContinueButton() {
    _isContinueButtonEnabled =
        _selectedActivities.length >= 3 && (_day1 || _day2 || _noBus);
  }

  _dismiss(bool refresh) {
    Navigator.pop(context, refresh);
  }

  _showNextScreen() async {
    bool close = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AsaServiceApplicationPage(
          student: widget.student,
          frequency: AsaServiceApplicationPage.MIE_VIEW_FREQ,
        ),
      ),
    );

    if (close != null && close) {
      _dismiss(close);
    }
  }

  _saveSelection() {
    setState(() {
      _loading = true;
    });
    int i = 1;
    for (Activity activity in _selectedActivities) {
      activity.priority = i;
      i++;
    }
    SaveActivitiesRequest saveActivitiesRequest = new SaveActivitiesRequest();
    saveActivitiesRequest.activities = _selectedActivities;
    saveActivitiesRequest.transportRequestDays = _getTransportRequestDays();
    saveAsaActivities(
            widget.student.id, widget.frequency, saveActivitiesRequest)
        .then((response) {
      if (response.success) {
        setState(() {
          _loading = false;
        });
        if (widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ) {
          _showNextScreen();
        } else {
          _dismiss(true);
        }
      } else {
        setState(() {
          _loading = false;
        });
        showErrorToast(response.error.detail);
      }
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      showErrorToast(error);
      print(error);
    });
  }

  void _day1Changed(bool value) => setState(() {
        _day1 = value;
        _noBus = false;
        _enableContinueButton();
      });

  void _day2Changed(bool value) => setState(() {
        _day2 = value;
        _noBus = false;
        _enableContinueButton();
      });

  void _noBusChanged(bool value) => setState(() {
        _day1 = false;
        _day2 = false;
        _noBus = value;
        _enableContinueButton();
      });

  TransportRequestDays _getTransportRequestDays() {
    _transportRequestDays.monday = "";
    _transportRequestDays.tuesday = "";
    _transportRequestDays.wednesday = "";
    _transportRequestDays.thursday = "";
    _transportRequestDays.friday = "";
    _transportRequestDays.none = "";
    if (widget.frequency == AsaServiceApplicationPage.LUN_JUE_FREQ) {
      _day1
          ? _transportRequestDays.monday = "S"
          : _transportRequestDays.monday = "";
      _day2
          ? _transportRequestDays.thursday = "S"
          : _transportRequestDays.thursday = "";
    } else {
      _day1
          ? _transportRequestDays.tuesday = "S"
          : _transportRequestDays.tuesday = "";
      _day2
          ? _transportRequestDays.friday = "S"
          : _transportRequestDays.friday = "";
    }
    _noBus ? _transportRequestDays.none = "S" : _transportRequestDays.none = "";
    return _transportRequestDays;
  }
}
