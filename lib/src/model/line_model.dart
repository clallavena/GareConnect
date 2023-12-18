
import 'stop_area_model.dart';

class Line {
  String id;
  String name;
  String code;
  String color;
  String textColor;
  List<dynamic> codes;
  List<AlMode> physicalModes;
  AlMode commercialMode;
  List<Route> routes;
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
    required this.routes,
    required this.network,
    required this.openingTime,
    required this.closingTime,
    required this.geojson,
    required this.links,
  });

}

class AlMode {
  String id;
  String name;

  AlMode({
    required this.id,
    required this.name,
  });

}

class Geojson {
  String type;
  List<dynamic> coordinates;

  Geojson({
    required this.type,
    required this.coordinates,
  });

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

}