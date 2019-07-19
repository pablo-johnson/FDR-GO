enum RouteType { I, R }

class Route {
  int id;
  String code;
  String name;
  String stopBus;
  String typeTrip;
  String typeTripDescription;
  dynamic scheduleDefault;
  List<dynamic> schedules;
  dynamic driverDefault;
  List<dynamic> drivers;
  dynamic vehicle;

  Route({
    this.id,
    this.code,
    this.name,
    this.stopBus,
    this.typeTrip,
    this.typeTripDescription,
    this.scheduleDefault,
    this.schedules,
    this.driverDefault,
    this.drivers,
    this.vehicle,
  });

  factory Route.fromJson(Map<String, dynamic> json) => new Route(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        stopBus: json["stopBus"],
        typeTrip: json["typeTrip"],
        typeTripDescription: json["typeTripDescription"],
        scheduleDefault: json["scheduleDefault"],
        schedules: json["schedules"] != null
            ? new List<dynamic>.from(json["schedules"].map((x) => x))
            : null,
        driverDefault: json["driverDefault"],
        drivers: json["drivers"] != null
            ? new List<dynamic>.from(json["drivers"].map((x) => x))
            : null,
        vehicle: json["vehicle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "stopBus": stopBus,
        "typeTrip": typeTrip,
        "typeTripDescription": typeTripDescription,
        "scheduleDefault": scheduleDefault,
        "schedules": new List<dynamic>.from(schedules.map((x) => x)),
        "driverDefault": driverDefault,
        "drivers": new List<dynamic>.from(drivers.map((x) => x)),
        "vehicle": vehicle,
      };
}
