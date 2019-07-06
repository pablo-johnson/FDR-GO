// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fdr_go/data/error.dart';

import '../family.dart';
import '../service.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String name;
  String email;
  String token;
  String type;
  int expireMinutes;
  List<Service> services;
  List<Profile> profiles;
  List<Reference> references;
  List<Family> families;
  Error error;
  bool success;
  String targetUrl;

  LoginResponse({
    this.name,
    this.email,
    this.token,
    this.type,
    this.expireMinutes,
    this.services,
    this.profiles,
    this.references,
    this.families,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      new LoginResponse(
        name: json["name"],
        email: json["email"],
        token: json["token"],
        type: json["type"],
        expireMinutes: json["expireMinutes"],
        services: json["services"] != null
            ? new List<Service>.from(
                json["services"].map((x) => Service.fromJson(x)))
            : null,
        profiles: json["profiles"] != null
            ? new List<Profile>.from(
                json["profiles"].map((x) => Profile.fromJson(x)))
            : null,
        references: json["references"] != null
            ? new List<Reference>.from(
                json["references"].map((x) => Reference.fromJson(x)))
            : null,
        families: json["families"] != null
            ? new List<Family>.from(
                json["families"].map((x) => Family.fromJson(x)))
            : null,
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "token": token,
        "type": type,
        "expireMinutes": expireMinutes,
        "services": new List<Service>.from(services.map((x) => x.toJson())),
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
