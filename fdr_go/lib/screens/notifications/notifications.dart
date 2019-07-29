import 'package:fdr_go/data/notification.dart' as MyNotification;
import 'package:fdr_go/screens/landing/menu.dart';
import 'package:fdr_go/services/notification_services.dart';
import 'package:fdr_go/services/bus_service_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';

import 'notification_detail.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _loading = true;
  List<MyNotification.Notification> notifications = new List();

  @override
  void initState() {
    super.initState();
    _getNotifications(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarySwatch['red'],
        title: Text("Notificaciones"),
      ),
      drawer: new MenuWidget(),
      backgroundColor: primarySwatch['blue'],
      body: Stack(
        children: <Widget>[
          _loading ? _buildProgressBarWidget() : Container(),
          Container(
            child: new RefreshIndicator(
              child: ListView.separated(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationListItem(index);
                },
                separatorBuilder: (context, index) {
                  return _buildSeparator();
                },
              ),
              onRefresh: getBusServices,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSeparator() {
    return Container(
      height: 1.0,
      color: primarySwatch['dividerColor'],
      child: Divider(),
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

  Widget _buildNotificationListItem(int index) {
    MyNotification.Notification notification = notifications[index];
    return GestureDetector(
      onTap: () {
        _openNotification(notification);
      },
      child: Container(
          color: notification.wasRead
              ? primarySwatch['notificationBackground']
              : primarySwatch['blue'],
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          height: 100.0,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundColor: notification.wasRead
                    ? primarySwatch['notificationAvatar']
                    : primarySwatch['notificationUnreadBackground'],
                child: Text(
                  getShortName(notification.title),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        notifications[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        notifications[index].name != null
                            ? notifications[index].name
                            : "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        notifications[index].message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          )),
    );
  }

  void _getNotifications(bool showLoading) {
    if (showLoading) {
      setState(() {
        _loading = true;
      });
    }
    getNotifications().then((notificationsResponse) {
      notifications = notificationsResponse.notifications;
      _loading = false;
      setState(() {});
    }).catchError((error) {
      print(error);
    });
    return null;
  }

  _openNotification(MyNotification.Notification notification) async {
    final bool refresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            NotificationDetailPage(notification: notification),
      ),
    );

    if (refresh != null && refresh) {
      _getNotifications(true);
    }
  }
}
