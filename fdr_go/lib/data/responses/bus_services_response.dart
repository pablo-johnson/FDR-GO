// To parse this JSON data, do
//
//     final servicesResponse = servicesResponseFromJson(jsonString);

import 'dart:convert';

import '../error.dart';
import '../bus_service.dart';

BusServicesResponse servicesResponseFromJson(String str) =>
    BusServicesResponse.fromJson(json.decode(str));

String servicesResponseToJson(BusServicesResponse data) =>
    json.encode(data.toJson());

class BusServicesResponse {
  List<BusService> services;
  Error error;
  bool success;
  String targetUrl;

  BusServicesResponse({
    this.services,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory BusServicesResponse.fromJson(Map<String, dynamic> json) =>
      new BusServicesResponse(
        services: json["services"] != null
            ? new List<BusService>.from(
                json["services"].map((x) => BusService.fromJson(x)))
            : null,
        error: json["error"],
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "services": new List<BusService>.from(services.map((x) => x.toJson())),
        "error": error,
        "success": success,
        "targetUrl": targetUrl,
      };
}
