class Student {
  String code;
  int id;
  String name;
  bool isAdd;

  Student({
    this.code,
    this.id,
    this.name,
    this.isAdd,
  });

  factory Student.fromJson(Map<String, dynamic> json) => new Student(
        code: json["code"],
        id: json["id"],
        name: json["name"],
        isAdd: json["isAdd"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "id": id,
        "name": name,
        "isAdd": isAdd,
      };
}
