// To parse this JSON data, do
//
//     final asaServicesResponse = asaServicesResponseFromJson(jsonString);

import 'dart:convert';

import '../asa_service.dart';
import '../error.dart';
import '../successful.dart';

AsaServicesResponse asaServicesResponseFromJson(String str) =>
    AsaServicesResponse.fromJson(json.decode(str));

String asaServicesResponseToJson(AsaServicesResponse data) =>
    json.encode(data.toJson());

class AsaServicesResponse {
  List<AsaService> services;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  AsaServicesResponse({
    this.services,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory AsaServicesResponse.fromJson(Map<String, dynamic> json) =>
      new AsaServicesResponse(
        services: new List<AsaService>.from(
            json["services"].map((x) => AsaService.fromJson(x))),
        error: json["error"],
        success: json["success"],
        successful: json["successful"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "services": new List<AsaService>.from(services.map((x) => x.toJson())),
        "error": error,
        "success": success,
        "successful": successful,
        "targetUrl": targetUrl,
      };
}
