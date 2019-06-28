// To parse this JSON data, do
//
//     final studentsResponse = studentsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';
import 'package:fdr_go/data/family.dart';

StudentsResponse studentsResponseFromJson(String str) =>
    StudentsResponse.fromJson(json.decode(str));

String studentsResponseToJson(StudentsResponse data) =>
    json.encode(data.toJson());

class StudentsResponse {
  List<Family> families;
  Error error;
  bool success;
  String targetUrl;

  StudentsResponse({
    this.families,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory StudentsResponse.fromJson(Map<String, dynamic> json) =>
      new StudentsResponse(
        families: new List<Family>.from(
            json["families"].map((x) => Family.fromJson(x))),
        error: Error.fromJson(json["error"]),
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "families": new List<dynamic>.from(families.map((x) => x.toJson())),
        "error": error.toJson(),
        "success": success,
        "targetUrl": targetUrl,
      };
}
