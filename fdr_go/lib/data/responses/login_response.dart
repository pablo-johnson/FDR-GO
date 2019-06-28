// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';

import '../family.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String name;
  String token;
  String type;
  int expireMinutes;
  List<Profile> profiles;
  List<Reference> references;
  List<Family> families;
  Error error;
  bool success;
  String targetUrl;

  LoginResponse({
    this.name,
    this.token,
    this.type,
    this.expireMinutes,
    this.profiles,
    this.references,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        name: json["name"],
        token: json["token"],
        type: json["type"],
        expireMinutes: json["expireMinutes"],
        profiles: json["profiles"] != null
            ? new List<Profile>.from(
                json["profiles"].map((x) => Profile.fromJson(x)))
            : null,
        references: json["references"] != null
            ? new List<Reference>.from(
                json["references"].map((x) => Reference.fromJson(x)))
            : null,
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "token": token,
        "type": type,
        "expireMinutes": expireMinutes,
        "profiles": new List<dynamic>.from(profiles.map((x) => x.toJson())),
        "references": new List<dynamic>.from(references.map((x) => x.toJson())),
        "families": new List<Family>.from(families.map((x) => x.toJson())),
        "error": error.toJson(),
        "success": success,
        "targetUrl": targetUrl,
      };
}

class Profile {
  String profile;

  Profile({
    this.profile,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => new Profile(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
      };
}

class Reference {
  String proReferencia;
  String proCodigoReferencia;
  int proIdReferencia;

  Reference({
    this.proReferencia,
    this.proCodigoReferencia,
    this.proIdReferencia,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => new Reference(
        proReferencia: json["proReferencia"],
        proCodigoReferencia: json["proCodigoReferencia"],
        proIdReferencia: json["proIdReferencia"],
      );

  Map<String, dynamic> toJson() => {
        "proReferencia": proReferencia,
        "proCodigoReferencia": proCodigoReferencia,
        "proIdReferencia": proIdReferencia,
      };
}
