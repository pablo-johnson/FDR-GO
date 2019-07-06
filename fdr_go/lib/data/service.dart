import 'package:fdr_go/data/error.dart';
import 'package:fdr_go/data/route.dart';
import 'package:fdr_go/data/student.dart';

class Service {
  int id;
  int studentId;
  Student student;
  Route route;
  String status;
  String statusDescription;
  String locationStatus;
  String locationStatusDescription;
  Error error;
  bool success;
  String targetUrl;

  Service({
    this.id,
    this.studentId,
    this.student,
    this.route,
    this.status,
    this.statusDescription,
    this.locationStatus,
    this.locationStatusDescription,
    this.error,
    this.success,
    this.targetUrl,
  });

  factory Service.fromJson(Map<String, dynamic> json) => new Service(
        id: json["id"],
        studentId: json["studentId"],
        student: Student.fromJson(json["student"]),
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
        status: json["status"],
        statusDescription: json["statusDescription"] == null
            ? null
            : json["statusDescription"],
        locationStatus:
            json["locationStatus"] == null ? null : json["locationStatus"],
        locationStatusDescription: json["locationStatusDescription"] == null
            ? null
            : json["locationStatusDescription"],
        error: json["error"],
        success: json["success"],
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "studentId": studentId,
        "student": student.toJson(),
        "route": route == null ? null : route.toJson(),
        "status": status,
        "statusDescription":
            statusDescription == null ? null : statusDescription,
        "locationStatus": locationStatus == null ? null : locationStatus,
        "locationStatusDescription": locationStatusDescription == null
            ? null
            : locationStatusDescription,
        "error": error == null ? null : error.toJson(),
        "success": success,
        "targetUrl": targetUrl,
      };
}
