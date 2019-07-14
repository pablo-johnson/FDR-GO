import 'package:fdr_go/data/requests/create_account_request.dart';
import 'package:fdr_go/services/account_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/dialog.dart' as MyDialog;
import 'package:fdr_go/util/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateAccountDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  bool _isValidEmail = false;
  bool _isDone = false;
  bool _loading = false;
  String _confirmationMessage = "";

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyDialog.Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.dialogBackgroundRadio),
      ),
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.dialogBackgroundRadio),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(Consts.padding),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "Agregar Cuenta",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: primarySwatch['blue'],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  getTextFieldContainer(),
                  SizedBox(height: 20.0),
                  _loading
                      ? CircularProgressIndicator()
                      : _showConfirmationMessage(_confirmationMessage),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
            new SizedBox(
              width: double.infinity,
              height: Consts.commonButtonHeight,
              child: RaisedButton(
                onPressed: _isValidEmail
                    ? () =>
                        _isDone ? Navigator.pop(context) : _callCreateAccount()
                    : null,
                disabledColor: primarySwatch['redDisabled'],
                disabledTextColor: primarySwatch['whiteDisabled'],
                textColor: Colors.white,
                color: _isDone ? primarySwatch['blue'] : primarySwatch['red'],
                splashColor: primarySwatch['redPressed'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(Consts.dialogBackgroundRadio),
                      bottomRight:
                          Radius.circular(Consts.dialogBackgroundRadio)),
                ),
                child: Text(
                  _isDone ? "ACEPTAR" : "ENVIAR",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextFieldContainer() {
    return Container(
      decoration: new BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: primarySwatch['textFieldBorder'],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: myController,
                onChanged: _validateEmail,
                readOnly: _isDone,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Correo',
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              width: 1.0,
              height: Consts.commonButtonHeight,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: primarySwatch['textFieldBorder'],
                    width: 2,
                  ),
                ),
              ),
            ),
            Container(
              height: Consts.commonButtonHeight,
              width: 50,
              child: Icon(
                _isValidEmail ? Icons.check : Icons.clear,
                color: _isValidEmail
                    ? primarySwatch['blue']
                    : primarySwatch['red'],
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  _validateEmail(String value) {
    _isValidEmail = validateEmail(value);
    setState(() {});
  }

  void _callCreateAccount() {
    setState(() {
      _loading = true;
    });
    var request = new CreateAccountRequest();
    request.appId = Consts.appId;
    request.username = myController.text;
    if (_isValidEmail) {
      createAccount(request).then((createAccountResponse) {
        if (createAccountResponse.error != null) {
          _confirmationMessage = createAccountResponse.error.detail;
          setState(() {
            _loading = false;
          });
          return;
        }
        setState(() {
          _loading = false;
          _isDone = true;
          _confirmationMessage = createAccountResponse.successful.message;
        });
      });
    }
  }

  Widget _showConfirmationMessage(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
