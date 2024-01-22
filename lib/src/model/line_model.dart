import 'stop_area_model.dart';
import 'dart:convert';

Line lineFromJson(String str) => Line.fromJson(json.decode(str));

String lineToJson(Line data) => json.encode(data.toJson());

class Line {
  String id;
  String name;
  String code;
  String color;
  String textColor;
  List<dynamic> codes;
  List<AlMode> physicalModes;
  AlMode commercialMode;
  List<Route>? routes;
  Network network;
  String openingTime;
  String closingTime;
  Geojson geojson;
  List<dynamic> links;

  Line({
    required this.id,
    required this.name,
    required this.code,
    required this.color,
    required this.textColor,
    required this.codes,
    required this.physicalModes,
    required this.commercialMode,
    this.routes,
    required this.network,
    required this.openingTime,
    required this.closingTime,
    required this.geojson,
    required this.links,
  });

  factory Line.fromJson(Map<String, dynamic> json) => Line(
    id: json["id"],
    name: json["name"],
    code: json["code"],
    color: json["color"],
    textColor: json["text_color"],
    codes: List<dynamic>.from(json["codes"].map((x) => x)),
    physicalModes: List<AlMode>.from(json["physical_modes"].map((x) => AlMode.fromJson(x))),
    commercialMode: AlMode.fromJson(json["commercial_mode"]),
    routes: json["routes"] == null ? [] : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
    network: Network.fromJson(json["network"]),
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    geojson: Geojson.fromJson(json["geojson"]),
    links: List<dynamic>.from(json["links"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "code": code,
    "color": color,
    "text_color": textColor,
    "codes": List<dynamic>.from(codes.map((x) => x)),
    "physical_modes": List<dynamic>.from(physicalModes.map((x) => x.toJson())),
    "commercial_mode": commercialMode.toJson(),
    "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
    "network": network.toJson(),
    "opening_time": openingTime,
    "closing_time": closingTime,
    "geojson": geojson.toJson(),
    "links": List<dynamic>.from(links.map((x) => x)),
  };
}

class AlMode {
  String id;
  String name;

  AlMode({
    required this.id,
    required this.name,
  });

  factory AlMode.fromJson(Map<String, dynamic> json) => AlMode(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class Geojson {
  String type;
  List<dynamic> coordinates;

  Geojson({
    required this.type,
    required this.coordinates,
  });

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
    type: json["type"],
    coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

class Network {
  String id;
  String name;
  List<dynamic> links;

  Network({
    required this.id,
    required this.name,
    required this.links,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: json["id"],
    name: json["name"],
    links: List<dynamic>.from(json["links"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "links": List<dynamic>.from(links.map((x) => x)),
  };
}

class Route {
  String id;
  String name;
  String isFrequence;
  String directionType;
  Direction direction;
  Geojson geojson;
  List<dynamic> links;

  Route({
    required this.id,
    required this.name,
    required this.isFrequence,
    required this.directionType,
    required this.direction,
    required this.geojson,
    required this.links,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    name: json["name"],
    isFrequence: json["is_frequence"],
    directionType: json["direction_type"],
    direction: Direction.fromJson(json["direction"]),
    geojson: Geojson.fromJson(json["geojson"]),
    links: List<dynamic>.from(json["links"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_frequence": isFrequence,
    "direction_type": directionType,
    "direction": direction.toJson(),
    "geojson": geojson.toJson(),
    "links": List<dynamic>.from(links.map((x) => x)),
  };
}

class Direction {
  String id;
  String name;
  int quality;
  StopArea stopArea;
  String embeddedType;

  Direction({
    required this.id,
    required this.name,
    required this.quality,
    required this.stopArea,
    required this.embeddedType,
  });

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
    id: json["id"],
    name: json["name"],
    quality: json["quality"],
    stopArea: StopArea.fromJson(json["stop_area"]),
    embeddedType: json["embedded_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quality": quality,
    "stop_area": stopArea.toJson(),
    "embedded_type": embeddedType,
  };
}