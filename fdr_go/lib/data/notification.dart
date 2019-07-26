import 'package:flutter/foundation.dart';

import 'attribute.dart';
import 'error.dart';
import 'successful.dart';

enum NotificationType { CT, CO, GE }

class Notification {
  int id;
  NotificationType type;
  String typeDescription;
  int criticality;
  String sendBy;
  String title;
  String message;
  String name;
  String date;
  bool wasRead;
  String color;
  String icon;
  Attribute attribute;
  Error error;
  bool success;
  Successful successful;
  String targetUrl;

  Notification({
    this.id,
    this.type,
    this.typeDescription,
    this.criticality,
    this.sendBy,
    this.title,
    this.message,
    this.name,
    this.date,
    this.wasRead,
    this.color,
    this.icon,
    this.attribute,
    this.error,
    this.success,
    this.successful,
    this.targetUrl,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => new Notification(
        id: json["id"],
        type: NotificationType.values.firstWhere((e) => describeEnum(e) == json["type"]),
        typeDescription: json["typeDescription"],
        criticality: json["criticality"],
        sendBy: json["sendBy"],
        name: json["name"],
        title: json["title"],
        message: json["message"],
        date: json["date"],
        wasRead: json["wasRead"],
        color: json["color"],
        icon: json["icon"],
        attribute: json["attribute"] != null
            ? Attribute.fromJson(json["attribute"])
            : null,
        error: json["error"] != null ? Error.fromJson(json["error"]) : null,
        success: json["success"],
        successful: json["successful"] != null
            ? Successful.fromJson(json["successful"])
            : null,
        targetUrl: json["targetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "typeDescription": typeDescription,
        "criticality": criticality,
        "sendBy": sendBy,
        "name": name,
        "title": title,
        "message": message,
        "date": date,
        "wasRead": wasRead,
        "color": color,
        "icon": icon,
        "attribute": attribute.toJson(),
        "error": error.toJson(),
        "success": success,
        "successful": successful.toJson(),
        "targetUrl": targetUrl,
      };
}
