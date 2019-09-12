// To parse this JSON data, do
//
//     final activitiesResponse = activitiesResponseFromJson(jsonString);

import 'dart:convert';

import '../activity.dart';
import '../error.dart';
import '../successful.dart';
import '../transport_request_days.dart';

ActivitiesResponse activitiesResponseFromJson(String str) =>
    ActivitiesResponse.fromJson(json.decode(str));

String activitiesResponseToJson(ActivitiesResponse data) =>
    json.encode(data.toJson());

class ActivitiesResponse {
  List<Activity> activities;
  TransportRequestDays transportRequestDays;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  ActivitiesResponse({
    this.activities,
    this.transportRequestDays,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory ActivitiesResponse.fromJson(Map<String, dynamic> json) =>
      new ActivitiesResponse(
        activities: new List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
        transportRequestDays: json["transportRequestDays"] != null
            ? TransportRequestDays.fromJson(json["transportRequestDays"])
            : null,
        error: json["error"],
        success: json["success"],
        successful: json["successful"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "activities":
            new List<Activity>.from(activities.map((x) => x.toJson())),
        "transportRequestDays": transportRequestDays.toJson(),
        "error": error,
        "success": success,
        "successful": successful,
        "targetUrl": targetUrl,
      };
}
