// To parse this JSON data, do
//
//     final requestServiceRequest = requestServiceRequestFromJson(jsonString);

import 'dart:convert';

RequestServiceRequest requestServiceRequestFromJson(String str) =>
    RequestServiceRequest.fromJson(json.decode(str));

String requestServiceRequestToJson(RequestServiceRequest data) =>
    json.encode(data.toJson());

class RequestServiceRequest {
  int studentId;
  String dateRequest;
  String dateFrom;
  String serviceMode;

  RequestServiceRequest({
    this.studentId,
    this.dateRequest,
    this.dateFrom,
    this.serviceMode,
  });

  factory RequestServiceRequest.fromJson(Map<String, dynamic> json) =>
      new RequestServiceRequest(
        studentId: json["studentId"],
        dateRequest: json["dateRequest"],
        dateFrom: json["dateFrom"],
        serviceMode: json["serviceMode"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "dateRequest": dateRequest,
        "dateFrom": dateFrom,
        "serviceMode": serviceMode,
      };
}
