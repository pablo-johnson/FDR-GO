import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/dialog.dart' as MyDialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    this.message,
  });

  final String message;

  @override
  State<StatefulWidget> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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
    return Container(
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
                  FdrLocalizations.of(context).notificationDetailMessage,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: primarySwatch['blue'],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                    color: primarySwatch['blue'],
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          new SizedBox(
            width: double.infinity,
            height: Consts.commonButtonHeight,
            child: RaisedButton(
              onPressed: () => Navigator.pop(context),
              textColor: Colors.white,
              color: primarySwatch['blue'],
              splashColor: primarySwatch['bluePressed'],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(Consts.dialogBackgroundRadio),
                    bottomRight: Radius.circular(Consts.dialogBackgroundRadio)),
              ),
              child: Text(
                FdrLocalizations.of(context).ok.toUpperCase(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
