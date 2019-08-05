// To parse this JSON data, do
//
//     final fcmRequest = fcmRequestFromJson(jsonString);

import 'dart:convert';

FcmRequest fcmRequestFromJson(String str) => FcmRequest.fromJson(json.decode(str));

String fcmRequestToJson(FcmRequest data) => json.encode(data.toJson());

class FcmRequest {
  String deviceToken;

  FcmRequest({
    this.deviceToken,
  });

  factory FcmRequest.fromJson(Map<String, dynamic> json) => new FcmRequest(
    deviceToken: json["deviceToken"],
  );

  Map<String, dynamic> toJson() => {
    "deviceToken": deviceToken,
  };
}
