class Student {
  String code;
  int id;
  String name;
  String lastName;
  String grade;
  String address;
  String photoUrl;
  bool isAdd;

  Student({
    this.code,
    this.id,
    this.name,
    this.lastName,
    this.grade,
    this.address,
    this.photoUrl,
    this.isAdd,
  });

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
        code: json["code"],
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        grade: json["grade"],
        address: json["address"],
        photoUrl: json["photoUrl"],
        isAdd: json["isAdd"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "name": name,
        "lastName": lastName,
        "grade": grade,
        "address": address,
        "photoUrl": photoUrl,
        "isAdd": isAdd,
      };
}
