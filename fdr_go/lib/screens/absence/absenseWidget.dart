import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/screens/calendar/calendar.dart' as DateRangePicker;
import 'package:fdr_go/services/student_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsencePage extends StatefulWidget {
  final Student student;

  const AbsencePage({@required this.student}) : assert(student != null);

  @override
  State<StatefulWidget> createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final absenceReasonController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Comunicar Inasistencia"),
      ),
      backgroundColor: Colors.white,
      body: buildAbsenceWidget(widget.student),
    );
  }

  Widget buildAbsenceWidget(Student student) {
    int id = student.id;
    return Stack(
      children: <Widget>[
        _loading
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: primarySwatch['progressBackground'],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
        Column(
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
                child: Hero(
                  tag: "hero$id",
                  child: Text(
                    student.name + " " + student.lastName,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                student.grade,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: _loading
                  ? primarySwatch['progressBackground']
                  : primarySwatch['white70'],
              child: Divider(),
            ),
            SizedBox(
              height: 10.0,
            ),
            _buildDateFields(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Motivo de Inasistencia*",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: TextField(
                  controller: absenceReasonController,
                  maxLines: 10,
                  minLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: const Color(0xffBECCDA),
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            _buildActionButtons(),
          ],
        ),
      ],
    );
  }

  Container _buildDateFields() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Fecha Desde*",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  child: TextField(
                    controller: fromDateController,
                    readOnly: true,
                    onTap: () => _showCalendar(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                      labelText: "Desde",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: const Color(0xffBECCDA),
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Fecha Hasta*",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: TextField(
                    controller: toDateController,
                    readOnly: true,
                    onTap: () => _showCalendar(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                      ),
                      labelText: "Hasta",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: const Color(0xffBECCDA),
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
                "Cancelar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading ? null : () => _dismiss(),
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
                "Aceptar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading ? null : () => _registerAbsence(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    fromDateController.dispose();
    toDateController.dispose();
    absenceReasonController.dispose();
    super.dispose();
  }

  _showCalendar() async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDateController.text?.isEmpty ?? true
            ? new DateTime.now().add(new Duration(hours: 1))
            : new DateFormat("dd/MM/yyyy").parse(fromDateController.text),
        initialLastDate: toDateController.text?.isEmpty ?? true
            ? new DateTime.now().add(new Duration(days: 1))
            : new DateFormat("dd/MM/yyyy").parse(toDateController.text),
        firstDate: new DateTime.now().add(new Duration(days: -1)),
        lastDate: new DateTime(2020));
    if (picked != null && picked.length == 2) {
      fromDateController.text = new DateFormat("dd/MM/yyyy").format(picked[0]);
      toDateController.text = new DateFormat("dd/MM/yyyy").format(picked[1]);
    }
  }

  _registerAbsence() {
    setState(() {
      _loading = true;
    });
    registerAbsence(widget.student.id, fromDateController.text,
            toDateController.text, absenceReasonController.text)
        .then((absenceResponse) {
      if (absenceResponse.success) {
        _loading = false;
        _dismiss();
      }
    });
  }

  _dismiss() {
    Navigator.pop(context);
  }
}
