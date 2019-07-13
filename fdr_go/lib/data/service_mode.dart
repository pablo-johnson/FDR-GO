class ServiceMode {
  String code;
  String description;
  dynamic explication;
  String textValue1;
  String textValue2;

  ServiceMode({
    this.code,
    this.description,
    this.explication,
    this.textValue1,
    this.textValue2,
  });

  factory ServiceMode.fromJson(Map<String, dynamic> json) => new ServiceMode(
        code: json["code"],
        description: json["description"],
        explication: json["explication"],
        textValue1: json["textValue1"],
        textValue2: json["textValue2"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
        "explication": explication,
        "textValue1": textValue1,
        "textValue2": textValue2,
      };
}
