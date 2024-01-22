// To parse this JSON data, do
//
//     final ptoAuto = ptoAutoFromJson(jsonString);

import 'dart:convert';

import 'package:gare_connect/src/model/stop_area_model.dart';
import 'package:gare_connect/src/model/line_model.dart';

import 'enum_values.dart';

PtoAuto ptoAutoFromJson(String str) => PtoAuto.fromJson(json.decode(str));

String ptoAutoToJson(PtoAuto data) => json.encode(data.toJson());

/// PtoAuto model, used for the pto autocomplete endpoint
class PtoAuto {
  List<dynamic> disruptions;
  List<PtObject> ptObjects;
  Context context;

  PtoAuto({
    required this.disruptions,
    required this.ptObjects,
    required this.context
  });

  factory PtoAuto.fromJson(Map<String, dynamic> json) => PtoAuto(
    disruptions: List<dynamic>.from(json["disruptions"].map((x) => x)),
    ptObjects: List<PtObject>.from(json["pt_objects"].map((x) => PtObject.fromJson(x))),
    context: Context.fromJson(json["context"]),
  );

  Map<String, dynamic> toJson() => {
    "disruptions": List<dynamic>.from(disruptions.map((x) => x)),
    "pt_objects": List<dynamic>.from(ptObjects.map((x) => x.toJson())),
    "context": context.toJson(),
  };
}

class Context {
  String currentDatetime;
  Timezone timezone;

  Context({
    required this.currentDatetime,
    required this.timezone,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
    currentDatetime: json["current_datetime"],
    timezone: timezoneValues.map[json["timezone"]]!,
  );

  Map<String, dynamic> toJson() => {
    "current_datetime": currentDatetime,
    "timezone": timezoneValues.reverse[timezone],
  };
}

enum Timezone {
  EUROPE_PARIS
}

final timezoneValues = EnumValues({
  "Europe/Paris": Timezone.EUROPE_PARIS
});

class PtObject {
  String id;
  String name;
  int quality;
  StopArea? stopArea;
  EmbeddedType embeddedType;
  Line? line;
  Route? route;

  PtObject({
    required this.id,
    required this.name,
    required this.quality,
    this.stopArea,
    required this.embeddedType,
    this.line,
    this.route,
  });

  factory PtObject.fromJson(Map<String, dynamic> json) => PtObject(
    id: json["id"],
    name: json["name"],
    quality: json["quality"],
    stopArea: json["stop_area"] == null ? null : StopArea.fromJson(json["stop_area"]),
    embeddedType: embeddedTypeValues.map[json["embedded_type"]]!,
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
    route: json["route"] == null ? null : Route.fromJson(json["route"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quality": quality,
    "stop_area": stopArea?.toJson(),
    "embedded_type": embeddedTypeValues.reverse[embeddedType],
    "line": line?.toJson(),
    "route": route?.toJson(),
  };
}

enum EmbeddedType {
  LINE,
  ROUTE,
  STOP_AREA
}

final embeddedTypeValues = EnumValues({
  "line": EmbeddedType.LINE,
  "route": EmbeddedType.ROUTE,
  "stop_area": EmbeddedType.STOP_AREA
});

class Route {
  String id;
  String name;
  String isFrequence;
  String directionType;
  Direction direction;
  Geojson geojson;
  List<dynamic> links;
  Line? line;

  Route({
    required this.id,
    required this.name,
    required this.isFrequence,
    required this.directionType,
    required this.direction,
    required this.geojson,
    required this.links,
    this.line,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
    id: json["id"],
    name: json["name"],
    isFrequence: json["is_frequence"],
    directionType: json["direction_type"],
    direction: Direction.fromJson(json["direction"]),
    geojson: Geojson.fromJson(json["geojson"]),
    links: List<dynamic>.from(json["links"].map((x) => x)),
    line: json["line"] == null ? null : Line.fromJson(json["line"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "is_frequence": isFrequence,
    "direction_type": directionType,
    "direction": direction.toJson(),
    "geojson": geojson.toJson(),
    "links": List<dynamic>.from(links.map((x) => x)),
    "line": line?.toJson(),
  };
}

class Direction {
  String id;
  String name;
  int quality;
  StopArea stopArea;
  EmbeddedType embeddedType;

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
    embeddedType: embeddedTypeValues.map[json["embedded_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quality": quality,
    "stop_area": stopArea.toJson(),
    "embedded_type": embeddedTypeValues.reverse[embeddedType],
  };
}

class AdministrativeRegion {
  String id;
  String name;
  int level;
  String zipCode;
  String label;
  String insee;
  Coord coord;

  AdministrativeRegion({
    required this.id,
    required this.name,
    required this.level,
    required this.zipCode,
    required this.label,
    required this.insee,
    required this.coord,
  });

  factory AdministrativeRegion.fromJson(Map<String, dynamic> json) => AdministrativeRegion(
    id: json["id"],
    name: json["name"],
    level: json["level"],
    zipCode: json["zip_code"],
    label: json["label"],
    insee: json["insee"],
    coord: Coord.fromJson(json["coord"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "level": level,
    "zip_code": zipCode,
    "label": label,
    "insee": insee,
    "coord": coord.toJson(),
  };
}

class Coord {
  String lon;
  String lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"],
    lat: json["lat"],
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Code {
  CodeType type;
  String value;

  Code({
    required this.type,
    required this.value,
  });

  factory Code.fromJson(Map<String, dynamic> json) => Code(
    type: codeTypeValues.map[json["type"]]!,
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": codeTypeValues.reverse[type],
    "value": value,
  };
}

enum CodeType {
  SECONDARY_ID,
  SOURCE,
  UIC
}

final codeTypeValues = EnumValues({
  "secondary_id": CodeType.SECONDARY_ID,
  "source": CodeType.SOURCE,
  "uic": CodeType.UIC
});

class Geojson {
  GeojsonType type;
  List<dynamic> coordinates;

  Geojson({
    required this.type,
    required this.coordinates,
  });

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
    type: geojsonTypeValues.map[json["type"]]!,
    coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": geojsonTypeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

enum GeojsonType {
  MULTI_LINE_STRING
}

final geojsonTypeValues = EnumValues({
  "MultiLineString": GeojsonType.MULTI_LINE_STRING
});

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


