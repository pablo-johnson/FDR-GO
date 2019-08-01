class Activity {
  int id;
  int inscriptionId;
  int frequencyId;
  String description;
  String frequency;
  String selected;
  int priority;
  String startTime;
  String endTime;

  Activity({
    this.id,
    this.inscriptionId,
    this.frequencyId,
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
        frequencyId: json["frequencyId"],
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
        "frequencyId": frequencyId,
        "description": description,
        "frequency": frequency,
        "selected": selected,
        "priority": priority,
        "startTime": startTime,
        "endTime": endTime,
      };
}
