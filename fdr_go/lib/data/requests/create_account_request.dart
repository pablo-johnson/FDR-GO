// To parse this JSON data, do
//
//     final createAccountRequest = createAccountRequestFromJson(jsonString);

import 'dart:convert';

CreateAccountRequest createAccountRequestFromJson(String str) =>
    CreateAccountRequest.fromJson(json.decode(str));

String createAccountRequestToJson(CreateAccountRequest data) =>
    json.encode(data.toJson());

class CreateAccountRequest {
  String username;
  String appId;

  CreateAccountRequest({
    this.username,
    this.appId,
  });

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) =>
      new CreateAccountRequest(
        username: json["username"],
        appId: json["appId"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "appId": appId,
      };
}
