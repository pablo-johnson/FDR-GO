// To parse this JSON data, do
//
//     final studentsResponse = studentsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';

AbsenceResponse absenceResponseFromJson(String str) =>
    AbsenceResponse.fromJson(json.decode(str));

String absenceResponseToJson(AbsenceResponse data) =>
    json.encode(data.toJson());

class AbsenceResponse {
  bool success;
  String targetUrl;
  Error error;

  AbsenceResponse({
    this.success,
    this.targetUrl,
    this.error,
  });

  factory AbsenceResponse.fromJson(Map<String, dynamic> json) =>
      new AbsenceResponse(
        success: json["success"],
        targetUrl: json["targetUrl"],
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "targetUrl": targetUrl,
        "error": error.toJson(),
      };
}
