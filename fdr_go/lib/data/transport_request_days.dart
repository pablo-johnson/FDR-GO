class TransportRequestDays {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;

  TransportRequestDays({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  factory TransportRequestDays.fromJson(Map<String, dynamic> json) =>
      new TransportRequestDays(
        monday: json["monday"],
        tuesday: json["tuesday"],
        wednesday: json["wednesday"],
        thursday: json["thursday"],
        friday: json["friday"],
      );

  Map<String, dynamic> toJson() => {
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
      };
}
