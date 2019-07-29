import 'package:fdr_go/data/notification.dart' as MyNotification;
import 'package:fdr_go/services/notification_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:flutter/material.dart';

class NotificationDetailPage extends StatefulWidget {
  final MyNotification.Notification notification;

  const NotificationDetailPage({@required this.notification})
      : assert(notification != null);

  @override
  State<StatefulWidget> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  final academicPeriodController = TextEditingController();
  final sessionController = TextEditingController();
  final activityController = TextEditingController();
  final couchController = TextEditingController();
  final messageController = TextEditingController();

  bool _loading = false;
  MyNotification.NotificationType _notificationType;

  bool _refresh;

  @override
  void initState() {
    super.initState();
    _markNotificationAsRead(widget.notification);
  }

  @override
  Widget build(BuildContext context) {
    _notificationType = widget.notification.type;
    String title = _getTitle(_notificationType);
    return new WillPopScope(
      onWillPop: () {
        return _dismiss();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primarySwatch['red'],
          title: Text(title),
        ),
        backgroundColor: Colors.white,
        body: _buildNotificationWidget(widget.notification),
      ),
    );
  }

  Widget _buildNotificationWidget(MyNotification.Notification notification) {
    academicPeriodController.text = notification.attribute?.period;
    sessionController.text = notification.attribute?.session;
    activityController.text = notification.attribute?.activity;
    couchController.text = notification.attribute?.name;
    messageController.text = notification.message;
    BoxDecoration boxDecoration = new BoxDecoration(
        color: primarySwatch['readOnlyFieldBackground'],
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
              child: buildMainForm(notification, boxDecoration),
            ),
            _buildActionButtons(),
          ],
        ),
      ],
    );
  }

  Widget buildMainForm(
      MyNotification.Notification notification, BoxDecoration boxDecoration) {
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
                notification.name,
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
              "Grado: ", //+ notification.attribute.grade,
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
          Container(
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
                        "Periodo Académico",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 40.0,
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        decoration: boxDecoration,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: TextField(
                            controller: academicPeriodController,
                            readOnly: true,
                            style: TextStyle(fontSize: 15.0),
                            decoration: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible:
                      _notificationType == MyNotification.NotificationType.CO,
                  child: Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Sesión",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          margin: EdgeInsets.only(top: 10.0, left: 10.0),
                          decoration: boxDecoration,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                            child: TextField(
                              controller: sessionController,
                              readOnly: true,
                              style: TextStyle(fontSize: 15.0),
                              decoration: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _notificationType == MyNotification.NotificationType.CO,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                "Actividad",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _notificationType == MyNotification.NotificationType.CO,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 10.0),
                decoration: boxDecoration,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: TextField(
                    controller: activityController,
                    readOnly: true,
                    style: TextStyle(fontSize: 15.0),
                    decoration: null,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _notificationType == MyNotification.NotificationType.CO,
            child: Container(
              margin: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 10.0,
              ),
              child: Text(
                "Entrenador",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _notificationType == MyNotification.NotificationType.CO,
            child: Container(
              height: 40.0,
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              decoration: boxDecoration,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextField(
                  controller: couchController,
                  readOnly: true,
                  style: TextStyle(fontSize: 15.0),
                  decoration: null,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
            ),
            child: Text(
              "Mensaje",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: TextField(
              controller: messageController,
              maxLines: 8,
              minLines: 8,
              readOnly: true,
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

  Widget _buildActionButtons() {
    return new SizedBox(
      height: Consts.commonButtonHeight,
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        color: primarySwatch['blue'],
        disabledColor: primarySwatch['blueDisabled'],
        disabledTextColor: primarySwatch['whiteDisabled'],
        child: Text(
          "Cerrar",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        onPressed: _loading ? null : () => _dismiss(),
      ),
    );
  }

  @override
  void dispose() {
    academicPeriodController.dispose();
    sessionController.dispose();
    activityController.dispose();
    couchController.dispose();
    messageController.dispose();
    super.dispose();
  }

  _dismiss() {
    Navigator.pop(context, _refresh);
  }

  void _markNotificationAsRead(MyNotification.Notification notification) {
    markNotificationAsRead(notification.id).then((response) {
      if (response.success) {
        _refresh = true;
      }
    });
  }

  String _getTitle(MyNotification.NotificationType notificationType) {
    if (_notificationType != MyNotification.NotificationType.CO) {
      return widget.notification.title;
    } else {
      return widget.notification.attribute.activity;
    }
  }
}
