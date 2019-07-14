// To parse this JSON data, do
//
//     final error = errorFromJson(jsonString);

import 'dart:convert';

import 'validation_error.dart';

Error errorFromJson(String str) => Error.fromJson(json.decode(str));

String errorToJson(Error data) => json.encode(data.toJson());

class Error {
  int code;
  String message;
  String detail;
  String severity;
  String field;
  String ticket;
  List<ValidationError> validationErrors;
  int ref;

  Error({
    this.code,
    this.message,
    this.detail,
    this.severity,
    this.field,
    this.ticket,
    this.validationErrors,
    this.ref,
  });

  factory Error.fromJson(Map<String, dynamic> json) => new Error(
        code: json["code"],
        message: json["message"],
        detail: json["detail"],
        severity: json["severity"],
        field: json["field"],
        ticket: json["ticket"],
        validationErrors: json["validationErrors"] != null
            ? new List<ValidationError>.from(json["validationErrors"]
                .map((x) => ValidationError.fromJson(x)))
            : null,
        ref: json["ref"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "detail": detail,
        "severity": severity,
        "field": field,
        "ticket": ticket,
        "validationErrors":
            new List<ValidationError>.from(validationErrors.map((x) => x.toJson())),
        "ref": ref,
      };
}
