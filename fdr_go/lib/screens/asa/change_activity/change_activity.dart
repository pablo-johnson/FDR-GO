import 'package:fdr_go/data/activity.dart';
import 'package:fdr_go/data/requests/save_activity_request.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/services/asa_service_services.dart';
import 'package:fdr_go/util/ToastUtil.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/round_checkbox.dart';
import 'package:flutter/material.dart';

class ChangeActivityPage extends StatefulWidget {
  final Student student;
  final int frequency;

  static const LUN_JUE_FREQ = 1;
  static const MIE_VIEW_FREQ = 2;

  const ChangeActivityPage({@required this.student, @required this.frequency})
      : assert(student != null);

  @override
  State<StatefulWidget> createState() => _ChangeActivityPageState();
}

class _ChangeActivityPageState extends State<ChangeActivityPage> {
  bool _loading = true;
  bool _isContinueButtonEnabled = false;

  List<Activity> _activities = new List();
  Activity _selectedActivity;

  @override
  void initState() {
    super.initState();
    _getActivities(widget.student);
  }

  void _getActivities(Student student) {
    getAsaActivities(student.id, widget.frequency).then((activitiesResponse) {
      if (activitiesResponse.success) {
        setState(() {
          _loading = false;
          _activities = activitiesResponse.activities;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text(
          FdrLocalizations.of(context).changeAsaTitle,
        ), //"Cambiar ASA"),
      ),
      backgroundColor: Colors.white,
      body: _buildChangeActivityWidget(widget.student),
    );
  }

  Widget _buildChangeActivityWidget(Student student) {
    BoxDecoration boxDecoration = new BoxDecoration(
        color: primarySwatch['disabledTextFieldBackground'],
        border:
            new Border.all(color: primarySwatch['textFieldBorder'], width: 1.0),
        borderRadius: new BorderRadius.circular(4.0));

    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            FdrLocalizations.of(context).notificationDetailGrade +
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
      ],
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        return _buildActivitiesListItem(index);
      },
    );
  }

  Widget _buildActivitiesListItem(int index) {
    Activity activity = _activities[index];
    bool _checked = _selectedActivity == activity;
    return GestureDetector(
      onTap: () {
        setState(() {
          _changeState(activity, _checked);
          _enableContinueButton();
        });
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5.0,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: _checked ? primarySwatch['blue'] : Colors.white,
          border: new Border.all(color: primarySwatch['blue'], width: 1.0),
          borderRadius: new BorderRadius.circular(4.0),
        ),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: _checked ? Colors.white : primarySwatch['blue']),
                    borderRadius: new BorderRadius.circular(100),
                  ),
                  child: CircularCheckBox(
                    value: _checked,
                    tristate: false,
                    onChanged: (bool value) => setState(() {
                      _changeState(activity, _checked);
                      _enableContinueButton();
                    }),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              child: Text(
                activity.description,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: _checked ? Colors.white : primarySwatch['blue'],
                ),
              ),
            ),
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
                FdrLocalizations.of(context).cancel.toUpperCase(),
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
                FdrLocalizations.of(context).accept.toUpperCase(),
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
    _isContinueButtonEnabled = _selectedActivity != null;
  }

  _dismiss(bool refresh) {
    Navigator.pop(context, refresh);
  }

  _saveSelection() {
    setState(() {
      _loading = true;
    });
    SaveActivityRequest request = new SaveActivityRequest();
    request.id = _selectedActivity.id;
    request.inscriptionId = _selectedActivity.inscriptionId;
    request.description = _selectedActivity.description;
    request.frequency = _selectedActivity.frequency;
    saveAsaActivity(widget.student.id, widget.frequency, request)
        .then((response) {
      if (response.success) {
        setState(() {
          _loading = false;
        });
        _dismiss(true);
      }
    }).catchError((error) {
      setState(() {
        _loading = false;
      });
      showErrorToast(error);
      print(error);
    });
  }

  void _changeState(Activity activity, bool _checked) {
    _selectedActivity = activity;
    _checked = !_checked;
  }
}
