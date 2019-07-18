// To parse this JSON data, do
//
//     final createAccountRequest = createAccountRequestFromJson(jsonString);

import 'dart:convert';

ForgotPasswordRequest forgotPasswordRequestFromJson(String str) =>
    ForgotPasswordRequest.fromJson(json.decode(str));

String forgotPasswordRequestToJson(ForgotPasswordRequest data) =>
    json.encode(data.toJson());

class ForgotPasswordRequest {
  String email;
  String appId;

  ForgotPasswordRequest({
    this.email,
    this.appId,
  });

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      new ForgotPasswordRequest(
        email: json["email"],
        appId: json["appId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "appId": appId,
      };
}
