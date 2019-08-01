// To parse this JSON data, do
//
//     final saveActivityRequest = saveActivityRequestFromJson(jsonString);

import 'dart:convert';

SaveActivityRequest saveActivityRequestFromJson(String str) => SaveActivityRequest.fromJson(json.decode(str));

String saveActivityRequestToJson(SaveActivityRequest data) => json.encode(data.toJson());

class SaveActivityRequest {
  int id;
  int inscriptionId;
  String description;
  String frequency;

  SaveActivityRequest({
    this.id,
    this.inscriptionId,
    this.description,
    this.frequency,
  });

  factory SaveActivityRequest.fromJson(Map<String, dynamic> json) => new SaveActivityRequest(
    id: json["id"],
    inscriptionId: json["inscriptionId"],
    description: json["description"],
    frequency: json["frequency"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inscriptionId": inscriptionId,
    "description": description,
    "frequency": frequency,
  };
}
