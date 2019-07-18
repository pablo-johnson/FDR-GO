// To parse this JSON data, do
//
//     final requestServiceResponse = requestServiceResponseFromJson(jsonString);

import 'dart:convert';

import '../error.dart';
import '../successful.dart';

CommonResponse commonResponseFromJson(String str) =>
    CommonResponse.fromJson(json.decode(str));

String commonResponseToJson(CommonResponse data) =>
    json.encode(data.toJson());

class CommonResponse {
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  CommonResponse({
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      new CommonResponse(
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        successful: json["successful"] != null
            ? Successful.fromJson(json["successful"])
            : null,
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "error": error != null ? error.toJson() : null,
        "success": success,
        "successful": successful.toJson(),
        "targetUrl": targetUrl,
      };
}
