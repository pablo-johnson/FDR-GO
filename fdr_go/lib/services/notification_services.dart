import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/responses/common_response.dart';
import 'package:fdr_go/data/responses/notifications_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.busBaseUrl;

Future<NotificationsResponse> getNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.get(
    '$url/education/notifications',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return notificationsResponseFromJson(response.body);
}

Future<CommonResponse> markNotificationAsRead(
    int notificationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  final response = await http.put(
    '$url/education/notifications/$notificationId/readed',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token
    },
  );
  return commonResponseFromJson(response.body);
}
