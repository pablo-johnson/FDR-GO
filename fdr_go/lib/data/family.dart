

import 'package:fdr_go/data/student.dart';

class Family {
  String code;
  int id;
  String familyName;
  bool isAdd;
  List<Student> students;

  Family({
    this.code,
    this.id,
    this.familyName,
    this.isAdd,
    this.students,
  });

  factory Family.fromJson(Map<String, dynamic> json) => new Family(
    code: json["code"],
    id: json["id"],
    familyName: json["familyName"],
    isAdd: json["isAdd"],
    students: new List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "id": id,
    "familyName": familyName,
    "isAdd": isAdd,
    "students": new List<dynamic>.from(students.map((x) => x.toJson())),
  };
}