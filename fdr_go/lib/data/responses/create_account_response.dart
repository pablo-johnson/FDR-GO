// To parse this JSON data, do
//
//     final createAccountResponse = createAccountResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';

import '../successful.dart';

CreateAccountResponse createAccountResponseFromJson(String str) =>
    CreateAccountResponse.fromJson(json.decode(str));

String createAccountResponseToJson(CreateAccountResponse data) =>
    json.encode(data.toJson());

class CreateAccountResponse {
  String token;
  int tokenExpiration;
  String ticket;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  CreateAccountResponse({
    this.token,
    this.tokenExpiration,
    this.ticket,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      new CreateAccountResponse(
        token: json["token"],
        tokenExpiration: json["tokenExpiration"],
        ticket: json["ticket"],
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        successful: json["successful"] != null
            ? Successful.fromJson(json["successful"])
            : null,
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "tokenExpiration": tokenExpiration,
        "ticket": ticket,
        "error": error.toJson(),
        "success": success,
        "successful": successful.toJson(),
        "targetUrl": targetUrl,
      };
}
