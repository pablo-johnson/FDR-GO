class Attribute {
  int requestId;
  String contract;
  String period;
  String session;
  String activity;
  String couch;
  String name;
  String grade;

  Attribute({
    this.requestId,
    this.contract,
    this.period,
    this.session,
    this.activity,
    this.couch,
    this.name,
    this.grade,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => new Attribute(
    requestId: json["requestId"] == null ? null : json["requestId"],
    contract: json["contract"] == null ? null : json["contract"],
    period: json["period"] == null ? null : json["period"],
    session: json["session"] == null ? null : json["session"],
    activity: json["activity"] == null ? null : json["activity"],
    couch: json["couch"] == null ? null : json["couch"],
    name: json["name"] == null ? null : json["name"],
    grade: json["grade"] == null ? null : json["grade"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId == null ? null : requestId,
    "contract": contract == null ? null : contract,
    "period": period == null ? null : period,
    "session": session == null ? null : session,
    "activity": activity == null ? null : activity,
    "couch": couch == null ? null : couch,
    "name": name == null ? null : name,
    "grade": grade == null ? null : grade,
  };
}