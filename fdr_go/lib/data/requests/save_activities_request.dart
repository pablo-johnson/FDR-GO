// To parse this JSON data, do
//
//     final saveActivitiesRequest = saveActivitiesRequestFromJson(jsonString);

import 'dart:convert';

import '../activity.dart';
import '../transport_request_days.dart';

SaveActivitiesRequest saveActivitiesRequestFromJson(String str) =>
    SaveActivitiesRequest.fromJson(json.decode(str));

String saveActivitiesRequestToJson(SaveActivitiesRequest data) =>
    json.encode(data.toJson());

class SaveActivitiesRequest {
  List<Activity> activities;
  TransportRequestDays transportRequestDays;

  SaveActivitiesRequest({
    this.activities,
    this.transportRequestDays,
  });

  factory SaveActivitiesRequest.fromJson(Map<String, dynamic> json) =>
      new SaveActivitiesRequest(
        activities: new List<Activity>.from(
            json["activities"].map((x) => Activity.fromJson(x))),
        transportRequestDays:
            TransportRequestDays.fromJson(json["transportRequestDays"]),
      );

  Map<String, dynamic> toJson() => {
        "activities": new List<dynamic>.from(activities.map((x) => x.toJson())),
        "transportRequestDays": transportRequestDays.toJson(),
      };
}
