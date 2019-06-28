// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String username;
  String password;
  String appId;

  LoginRequest({
    this.username,
    this.password,
    this.appId,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => new LoginRequest(
        username: json["username"],
        password: json["password"],
        appId: json["appId"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "appId": appId,
      };
}
