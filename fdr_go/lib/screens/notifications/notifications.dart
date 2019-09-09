import 'dart:async';
import 'dart:core';

import 'package:fdr_go/data/notification.dart' as MyNotification;
import 'package:fdr_go/data/notification_menu.dart';
import 'package:fdr_go/data/requests/paging.dart';
import 'package:fdr_go/lang/fdr_localizations.dart';
import 'package:fdr_go/screens/landing/landing.dart';
import 'package:fdr_go/screens/landing/menu.dart';
import 'package:fdr_go/services/notification_services.dart';
import 'package:fdr_go/util/colors.dart';
import 'package:fdr_go/util/custom_load_more.dart';
import 'package:fdr_go/util/strings_util.dart';
import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';

import 'notification_detail.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _loading = true;
  bool _showEmptyScreen = false;

//  bool _loadMore = false;
  List<MyNotification.Notification> notifications = new List();

  NotificationMenu notificationMenu;

  Paging paging;

  @override
  void initState() {
    super.initState();
    notificationMenu = new NotificationMenu();
    notificationMenu.notifications = 0;
    _resetPaging();
    _getNotifications(false);
    _getNotificationsCount();
  }

  void _resetPaging() {
    notifications.clear();
    paging = new Paging();
    paging.pageNumber = 0;
    paging.existNextPage = true;
  }

  _onBackPressed() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LandingPage()));
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () {
        return _onBackPressed();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primarySwatch['red'],
          title: Text(
            FdrLocalizations.of(context).notificationsTitle,
          ),
        ),
        drawer: new MenuWidget(
          notificationMenu: notificationMenu,
        ),
        backgroundColor: primarySwatch['blue'],
        body: Stack(
          children: <Widget>[
            Container(
              child: new RefreshIndicator(
                child: LoadMore(
                  isFinish: !paging.existNextPage,
                  onLoadMore: () => _loadMore(),
                  whenEmptyLoad: false,
                  delegate: CustomLoadMoreDelegate(),
                  textBuilder: _buildEnglishText,
                  child: ListView.separated(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return _buildNotificationListItem(index);
                    },
                    separatorBuilder: (context, index) {
                      return _buildSeparator();
                    },
                  ),
                ),
                onRefresh: () {
                  _resetPaging();
                  return getNotifications(paging.pageNumber + 1)
                      .then((response) {
                    if (response.paging.pageNumber > paging.pageNumber) {
                      setState(() {
                        notifications.addAll(response.notifications);
                        paging = response.paging;
                      });
                    }
                  });
                },
              ),
            ),
            _loading ? _buildProgressBarWidget() : Container(),
            _showEmptyScreen ? _emptyScreen() : Container(),
          ],
        ),
      ),
    );
  }

  Future<bool> _loadMore() async {
//    print("onLoadMore");
//    await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    _getNotifications(false);
    return true;
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
    getNotifications(paging.pageNumber + 1).then((notificationsResponse) {
      if (notifications.length == 0 &&
          notificationsResponse.notifications.length == 0) {
        _showEmptyScreen = true;
      } else if (notificationsResponse.paging.pageNumber > paging.pageNumber) {
        notifications.addAll(notificationsResponse.notifications);
      }
      paging = notificationsResponse.paging;
      _loading = false;
      if (mounted) {
        setState(() {});
      }
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
      _resetPaging();
      _getNotifications(true);
      _getNotificationsCount();
    }
  }

  void _getNotificationsCount() {
    getNotificationsCount().then((response) {
      if (response.success) {
        notificationMenu.notifications = int.parse(response.successful.ref);
      }
    });
  }

  String _buildEnglishText(LoadMoreStatus status) {
    String text;
    switch (status) {
      case LoadMoreStatus.fail:
        text = "load fail, tap to retry";
        break;
      case LoadMoreStatus.idle:
        text = "wait for loading";
        break;
      case LoadMoreStatus.loading:
        text = "loading, wait for moment ...";
        break;
      case LoadMoreStatus.nomore:
        text = "";
        break;
      default:
        text = "";
    }
    return text;
  }

  Widget _emptyScreen() {
    return Container(
      color: Color(0xffF4F4F4),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.notifications_off,
              color: primarySwatch['red'],
              size: 100,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              FdrLocalizations.of(context).notificationsEmptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primarySwatch['red'],
                fontSize: 26.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
