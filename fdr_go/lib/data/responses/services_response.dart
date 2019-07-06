// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'dart:convert';

import '../error.dart';
import '../service.dart';

ServicesResponse servicesResponseFromJson(String str) =>
    ServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(ServicesResponse data) =>
    json.encode(data.toJson());

class ServicesResponse {
  List<Service> services;
  Error error;
  bool success;
  String targetUrl;

  ServicesResponse({
    this.services,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory ServicesResponse.fromJson(Map<String, dynamic> json) =>
      new ServicesResponse(
        services: json["services"] != null
            ? new List<Service>.from(
                json["services"].map((x) => Service.fromJson(x)))
            : null,
        error: json["error"],
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "services": new List<Service>.from(services.map((x) => x.toJson())),
        "error": error,
        "success": success,
        "targetUrl": targetUrl,
      };
}
