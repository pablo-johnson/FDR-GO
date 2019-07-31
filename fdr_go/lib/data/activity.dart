class Activity {
  int id;
  int inscriptionId;
  String description;
  String frequency;
  String selected;
  int priority;
  String startTime;
  String endTime;

  Activity({
    this.id,
    this.inscriptionId,
    this.description,
    this.frequency,
    this.selected,
    this.priority,
    this.startTime,
    this.endTime,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => new Activity(
        id: json["id"],
        inscriptionId: json["inscriptionId"],
        description: json["description"],
        frequency: json["frequency"],
        selected: json["selected"],
        priority: json["priority"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "inscriptionId": inscriptionId,
        "description": description,
        "frequency": frequency,
        "selected": selected,
        "priority": priority,
        "startTime": startTime,
        "endTime": endTime,
      };
}
