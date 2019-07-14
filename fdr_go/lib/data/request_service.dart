import 'package:fdr_go/data/error.dart';

class RequestService {
  int id;
  String code;
  int studentId;
  String dateRequest;
  String dateFrom;
  String dateTo;
  String serviceMode;
  String status;
  String observation;
  Error error;
  bool success;
  dynamic successful;
  dynamic targetUrl;

  RequestService({
    this.id,
    this.code,
    this.studentId,
    this.dateRequest,
    this.dateFrom,
    this.dateTo,
    this.serviceMode,
    this.status,
    this.observation,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory RequestService.fromJson(Map<String, dynamic> json) => new RequestService(
    id: json["id"],
    code: json["code"],
    studentId: json["studentId"],
    dateRequest: json["dateRequest"],
    dateFrom: json["dateFrom"],
    dateTo: json["dateTo"],
    serviceMode: json["serviceMode"],
    status: json["status"],
    observation: json["observation"],
    error: json["error"],
    success: json["success"],
    successful: json["successful"],
    targetUrl: json["targetUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "studentId": studentId,
    "dateRequest": dateRequest,
    "dateFrom": dateFrom,
    "dateTo": dateTo,
    "serviceMode": serviceMode,
    "status": status,
    "observation": observation,
    "error": error,
    "success": success,
    "successful": successful,
    "targetUrl": targetUrl,
  };
}