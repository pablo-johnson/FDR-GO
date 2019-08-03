import 'package:fdr_go/data/service_mode.dart';
import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/dialogs/date_calendar.dart' as DatePicker;
import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/services/bus_service_services.dart';
import 'package:fdr_go/util/ToastUtil.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusServiceApplicationPage extends StatefulWidget {
  final Student student;

  const BusServiceApplicationPage({@required this.student})
      : assert(student != null);

  @override
  State<StatefulWidget> createState() => _BusServiceApplicationPageState();
}

class _BusServiceApplicationPageState extends State<BusServiceApplicationPage> {
  final requestedDateController = TextEditingController();
  final requiredDateController = TextEditingController();
  final requestedByController = TextEditingController();
  final addressController = TextEditingController();
  var _modes = new List<ServiceMode>();

  bool _loading = false;
  bool _isContinueButtonEnabled = false;
  String parentName;

  ServiceMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _getParentName();
    _getServiceModes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Solicitud de Servicio de Bus"),
      ),
      backgroundColor: Colors.white,
      body: _buildServiceApplicationWidget(widget.student),
    );
  }

  Widget _buildServiceApplicationWidget(Student student) {
    requestedByController.text = parentName;
    addressController.text = widget.student.address;
    BoxDecoration boxDecoration = new BoxDecoration(
        color: primarySwatch['disabledTextFieldBackground'],
        border:
            new Border.all(color: primarySwatch['textFieldBorder'], width: 1.0),
        borderRadius: new BorderRadius.circular(4.0));

    return Stack(
      children: <Widget>[
        _loading ? _buildProgressBarWidget() : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: buildMainForm(student, boxDecoration),
            ),
            _buildActionButtons(),
          ],
        ),
      ],
    );
  }

  SingleChildScrollView buildMainForm(
      Student student, BoxDecoration boxDecoration) {
    return SingleChildScrollView(
      child: Column(
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
              FdrLocalizations.of(context).notificationDetailGrade + student.grade,
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
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Solicitado por",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            padding: EdgeInsets.all(5.0),
            decoration: boxDecoration,
            child: TextField(
              controller: requestedByController,
              maxLines: 1,
              enabled: false,
              decoration: null,
            ),
          ),
          _buildDateFields(boxDecoration),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Dirección según enrollment",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 5.0,
            ),
            padding: EdgeInsets.all(10.0),
            decoration: boxDecoration,
            child: TextField(
              controller: addressController,
              maxLines: 4,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              enabled: false,
              decoration: null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "* Si no está de acuerdo con esta dirección comuníquese con el área de transportes.",
              style: TextStyle(
                fontSize: 11.0,
                color: primarySwatch['red'],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
              bottom: 5.0,
            ),
            child: Text(
              "Modalidad *",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 40.0,
            decoration: boxDecoration,
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: _selectedMode,
                hint: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(FdrLocalizations.of(context).busServiceChooseMode),
                ),
                items: _modes.map((ServiceMode dropDownItem) {
                  return DropdownMenuItem<ServiceMode>(
                    value: dropDownItem,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(dropDownItem.description),
                    ),
                  );
                }).toList(),
                onChanged: (ServiceMode newValue) {
                  setState(() {
                    _selectedMode = newValue;
                    _enableContinueButton();
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              _selectedMode?.explication ?? "",
              style: TextStyle(
                fontSize: 11.0,
                color: primarySwatch['red'],
              ),
            ),
          ),
//          _buildActionButtons(),
        ],
      ),
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

  Container _buildDateFields(BoxDecoration boxDecoration) {
    requestedDateController.text =
        new DateFormat("dd/MM/yyyy").format(new DateTime.now());
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
                  "Fecha de Solicitud *",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 10.0, right: 10.0),
                  decoration: boxDecoration,
                  padding: EdgeInsets.only(left: 5.0),
                  child: TextField(
                    controller: requestedDateController,
                    readOnly: true,
                    enabled: false,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
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
                    "Fecha Requerida *",
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
                    controller: requiredDateController,
                    textAlignVertical: TextAlignVertical.center,
                    readOnly: true,
                    style: TextStyle(fontSize: 15.0),
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5.0),
                      suffixIcon: IconButton(
                        color: Colors.red,
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 15.0,
                        ),
                      ),
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
                "Enviar",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
              onPressed: _loading || !_isContinueButtonEnabled
                  ? null
                  : () => _sendServiceApplication(),
            ),
          ),
        ),
      ],
    );
  }

  void _enableContinueButton() {
    _isContinueButtonEnabled = _selectedMode != null &&
        requiredDateController.text != null &&
        requiredDateController.text.isNotEmpty;
  }

  _sendServiceApplication() {
    setState(() {
      _loading = true;
    });
    requestBusService(widget.student.id, requiredDateController.text,
            requestedDateController.text, _selectedMode.code)
        .then((requestServiceResponse) {
      if (requestServiceResponse.success) {
        showSuccessToast(requestServiceResponse.successful.message);
        setState(() {
          _loading = false;
        });
        _dismiss(true);
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void dispose() {
    requiredDateController.dispose();
    requestedDateController.dispose();
    requestedByController.dispose();
    addressController.dispose();
    super.dispose();
  }

  _dismiss(bool refresh) {
    Navigator.pop(context, refresh);
  }

  Future _selectDate() async {
    DateTime picked = await DatePicker.showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().add(new Duration(days: -1)),
        lastDate: new DateTime(2020));
    if (picked != null)
      setState(() {
        requiredDateController.text =
            new DateFormat("dd/MM/yyyy").format(picked);
        _enableContinueButton();
      });
  }

  _getServiceModes() {
    setState(() {
      _loading = true;
    });
    getBusServiceModes().then((serviceModesResponse) {
      if (serviceModesResponse.success) {
        setState(() {
          _loading = false;
          _modes = serviceModesResponse.parameters;
        });
      }
    });
  }

  Future _getParentName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    parentName = prefs.getString("userName");
  }
}
