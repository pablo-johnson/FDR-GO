import 'dart:async';
import 'dart:io';

import 'package:fdr_go/data/responses/common_response.dart';
import 'package:fdr_go/data/responses/notifications_response.dart';
import 'package:fdr_go/util/consts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String url = Consts.busBaseUrl;

Future<NotificationsResponse> getNotifications(int page) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.get(
    '$url/education/notifications?page=$page',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return notificationsResponseFromJson(response.body);
}

Future<CommonResponse> markNotificationAsRead(int notificationId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.put(
    '$url/education/notifications/$notificationId/readed',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return commonResponseFromJson(response.body);
}

Future<CommonResponse> getNotificationsCount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("authToken");
  String languageCode = prefs.getString("languageCode");
  final response = await http.get(
    '$url/education/notifications/countnew',
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
      HttpHeaders.acceptLanguageHeader: languageCode
    },
  );
  return commonResponseFromJson(response.body);
}
