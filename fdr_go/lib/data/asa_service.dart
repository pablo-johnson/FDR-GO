import 'package:fdr_go/data/student.dart';
import 'package:fdr_go/data/error.dart';

import 'activity.dart';
import 'successful.dart';

enum AsaServiceStatus { IN, PR, ER, RE }

class AsaService {
  int id;
  int studentId;
  Student student;
  List<Activity> activities;
  String serviceStatus;
  String stateDescription;
  bool buttonActive;
  String buttonDescription;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  AsaService({
    this.id,
    this.studentId,
    this.student,
    this.activities,
    this.serviceStatus,
    this.stateDescription,
    this.buttonActive,
    this.buttonDescription,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory AsaService.fromJson(Map<String, dynamic> json) => new AsaService(
    id: json["id"],
    studentId: json["studentId"],
    student: Student.fromJson(json["student"]),
    activities: new List<Activity>.from(
        json["activities"].map((x) => Activity.fromJson(x))),
    serviceStatus: json["serviceStatus"],
    stateDescription: json["stateDescription"],
    buttonActive: json["buttonActive"],
    buttonDescription: json["buttonDescription"],
    error: json["error"],
    success: json["success"],
    successful: json["successful"],
    targetUrl: json["targetUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentId": studentId,
    "student": student.toJson(),
    "activities": new List<Activity>.from(activities.map((x) => x)),
    "serviceStatus": serviceStatus,
    "stateDescription": stateDescription,
    "buttonActive": buttonActive,
    "buttonDescription": buttonDescription,
    "error": error,
    "success": success,
    "successful": successful,
    "targetUrl": targetUrl,
  };
}