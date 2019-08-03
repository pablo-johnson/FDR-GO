import 'package:fdr_go/lang/fdr_localizations_delegate.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:fdr_go/util/dialog.dart' as MyDialog;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectLanguageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
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
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              "Please select your language",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: primarySwatch['blue'],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Por favor selecciona tu idioma",
              style: TextStyle(
                fontSize: 16.0,
                color: primarySwatch['blue'],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      new FdrLocalizationsDelegate().load(Locale("en", "US"));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 120.0,
                      decoration: new BoxDecoration(
                        color: primarySwatch['red'],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            bottomLeft: new Radius.circular(10.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: AssetImage('assets/images/us_flag.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "English",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  height: 120.0,
                  color: primarySwatch['white70'],
                  child: Divider(),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      new FdrLocalizationsDelegate().load(Locale("es", "ES"));
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 120.0,
                      decoration: new BoxDecoration(
                        color: primarySwatch['red'],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            bottomRight: new Radius.circular(10.0)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 60.0,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: AssetImage('assets/images/es_flag.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Spanish",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
