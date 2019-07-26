// To parse this JSON data, do
//
//     final notificationsResponse = notificationsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/requests/paging.dart';

import '../error.dart';
import '../notification.dart';
import '../successful.dart';

NotificationsResponse notificationsResponseFromJson(String str) =>
    NotificationsResponse.fromJson(json.decode(str));

String notificationsResponseToJson(NotificationsResponse data) =>
    json.encode(data.toJson());

class NotificationsResponse {
  List<Notification> notifications;
  Paging paging;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  NotificationsResponse({
    this.notifications,
    this.paging,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      new NotificationsResponse(
        notifications: new List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        paging: json["paging"] != null ? Paging.fromJson(json["paging"]) : null,
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        successful: json["successful"] != null
            ? Successful.fromJson(json["successful"])
            : null,
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "notifications":
            new List<Notification>.from(notifications.map((x) => x.toJson())),
        "paging": paging.toJson(),
        "error": error.toJson(),
        "success": success,
        "successful": successful.toJson(),
        "targetUrl": targetUrl,
      };
}
