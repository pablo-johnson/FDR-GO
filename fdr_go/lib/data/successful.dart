class Successful {
  int id;
  String ref;
  String message;

  Successful({
    this.id,
    this.ref,
    this.message,
  });

  factory Successful.fromJson(Map<String, dynamic> json) => new Successful(
        id: json["id"],
        ref: json["ref"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref": ref,
        "message": message,
      };
}
