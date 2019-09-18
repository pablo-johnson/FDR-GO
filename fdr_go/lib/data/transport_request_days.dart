class TransportRequestDays {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String none;

  TransportRequestDays({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.none,
  });

  factory TransportRequestDays.fromJson(Map<String, dynamic> json) =>
      new TransportRequestDays(
        monday: json["monday"],
        tuesday: json["tuesday"],
        wednesday: json["wednesday"],
        thursday: json["thursday"],
        friday: json["friday"],
        none: json["none"],
      );

  Map<String, dynamic> toJson() => {
        "monday": monday,
        "tuesday": tuesday,
        "wednesday": wednesday,
        "thursday": thursday,
        "friday": friday,
        "none": none,
      };
}
