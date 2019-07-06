// To parse this JSON data, do
//
//     final studentsResponse = studentsResponseFromJson(jsonString);

import 'dart:convert';

AbsenceRequest absenceRequestFromJson(String str) =>
    AbsenceRequest.fromJson(json.decode(str));

String absenceRequestToJson(AbsenceRequest data) =>
    json.encode(data.toJson());

class AbsenceRequest {
  int studentId;
  String dateFrom;
  String dateTo;
  String observation;

  AbsenceRequest({
    this.studentId,
    this.dateFrom,
    this.dateTo,
    this.observation,
  });

  factory AbsenceRequest.fromJson(Map<String, dynamic> json) =>
      new AbsenceRequest(
        studentId: json["studentId"],
        dateFrom: json["dateFrom"],
        dateTo: json["dateTo"],
        observation: json["observation"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "observation": observation,
      };
}
