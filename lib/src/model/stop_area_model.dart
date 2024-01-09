import 'package:gare_connect/src/model/code_model.dart';
import 'package:gare_connect/src/model/coord_model.dart';

class StopArea{
  String id;
  String name;
  List<Code> codes;
  String timezone;
  String label;
  Coord coord;
  List<AdministrativeRegion?> administrativeRegions;

  StopArea({
    required this.id,
    required this.name,
    required this.codes,
    required this.timezone,
    required this.label,
    required this.coord,
    required this.administrativeRegions,
  });

  factory StopArea.fromJson(Map<String, dynamic> json) => StopArea(
    id: json["id"],
    name: json["name"],
    codes: List<Code>.from(json["codes"].map((x) => Code.fromJson(x))),
    timezone: json["timezone"],
    label: json["label"],
    coord: Coord.fromJson(json["coord"]),
    administrativeRegions: json["administrative_regions"] == null ? [] : List<AdministrativeRegion>.from(json["administrative_regions"]!.map((x) => AdministrativeRegion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "codes": List<dynamic>.from(codes.map((x) => x.toJson())),
    "timezone": timezone,
    "label": label,
    "coord": coord.toJson(),
  };

  @override
  String toString() {
    return 'StopArea{name: $name}';
  }
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