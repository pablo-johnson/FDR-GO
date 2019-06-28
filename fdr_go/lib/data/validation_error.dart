
class ValidationError {
  String field;
  String message;

  ValidationError({
    this.field,
    this.message,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) => new ValidationError(
    field: json["field"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "message": message,
  };
}