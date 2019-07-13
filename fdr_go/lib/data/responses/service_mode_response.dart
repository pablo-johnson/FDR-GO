// To parse this JSON data, do
//
//     final serviceModeResponse = serviceModeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';

import '../service_mode.dart';

ServiceModeResponse serviceModeResponseFromJson(String str) =>
    ServiceModeResponse.fromJson(json.decode(str));

String serviceModeResponseToJson(ServiceModeResponse data) =>
    json.encode(data.toJson());

class ServiceModeResponse {
  List<ServiceMode> parameters;
  Error error;
  bool success;
  dynamic successful;
  String targetUrl;

  ServiceModeResponse({
    this.parameters,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory ServiceModeResponse.fromJson(Map<String, dynamic> json) =>
      new ServiceModeResponse(
        parameters: new List<ServiceMode>.from(
            json["parameters"].map((x) => ServiceMode.fromJson(x))),
        error: json["error"],
        success: json["success"],
        successful: json["successful"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "parameters":
            new List<ServiceMode>.from(parameters.map((x) => x.toJson())),
        "error": error,
        "success": success,
        "successful": successful,
        "targetUrl": targetUrl,
      };
}
