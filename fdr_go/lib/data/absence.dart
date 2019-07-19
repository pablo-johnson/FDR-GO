class Absence {
  String dateFrom;
  String dateTo;
  String observation;

  Absence({
    this.dateFrom,
    this.dateTo,
    this.observation,
  });

  factory Absence.fromJson(Map<String, dynamic> json) => new Absence(
    dateFrom: json["dateFrom"],
    dateTo: json["dateTo"],
    observation: json["observation"],
  );

  Map<String, dynamic> toJson() => {
    "dateFrom": dateFrom,
    "dateTo": dateTo,
    "observation": observation,
  };
}