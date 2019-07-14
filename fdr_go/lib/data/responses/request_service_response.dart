// To parse this JSON data, do
//
//     final requestServiceResponse = requestServiceResponseFromJson(jsonString);

import 'dart:convert';

import '../error.dart';
import '../successful.dart';

RequestServiceResponse requestServiceResponseFromJson(String str) =>
    RequestServiceResponse.fromJson(json.decode(str));

String requestServiceResponseToJson(RequestServiceResponse data) =>
    json.encode(data.toJson());

class RequestServiceResponse {
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  RequestServiceResponse({
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory RequestServiceResponse.fromJson(Map<String, dynamic> json) =>
      new RequestServiceResponse(
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
