import 'package:fdr_go/data/error.dart';
import 'package:fdr_go/data/request_service.dart';
import 'package:fdr_go/data/route.dart';
import 'package:fdr_go/data/student.dart';

import 'absence.dart';

enum ServiceStatus { PC, PR, AC, DE }
enum LocationStatus { SB, GO, SC }

class Service {
  int id;
  int studentId;
  Student student;
  Route route;
  String status;
  String statusDescription;
  String locationStatus;
  String locationStatusDescription;
  RequestService requestService;
  Error error;
  bool success;
  bool isAbsence;
  List<Absence> absences;
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
    this.requestService,
    this.error,
    this.success,
    this.isAbsence,
    this.absences,
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
        requestService: json["requestService"] == null
            ? null
            : RequestService.fromJson(json["requestService"]),
        locationStatus:
            json["locationStatus"] == null ? null : json["locationStatus"],
        locationStatusDescription: json["locationStatusDescription"] == null
            ? null
            : json["locationStatusDescription"],
        error: json["error"],
        success: json["success"],
        isAbsence: json["isAbsence"],
        absences: json["absences"] != null
            ? new List<Absence>.from(
                json["absences"].map((x) => Absence.fromJson(x)))
            : null,
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
        "requestService":
            requestService == null ? null : requestService.toJson(),
        "locationStatus": locationStatus == null ? null : locationStatus,
        "locationStatusDescription": locationStatusDescription == null
            ? null
            : locationStatusDescription,
        "error": error == null ? null : error.toJson(),
        "success": success,
        "isAbsence": isAbsence,
        "absences": new List<Absence>.from(absences.map((x) => x.toJson())),
        "targetUrl": targetUrl,
      };
}
