import 'dart:convert';
import 'package:gare_connect/src/model/stop_area_model.dart';
import 'line_model.dart';

Pto ptoFromJson(String str) => Pto.fromJson(json.decode(str));

String ptoToJson(Pto data) => json.encode(data.toJson());

class Pto {
  Pagination pagination;
  List<FeedPublisher> feedPublishers;
  Context context;
  List<StopArea>? stopAreas;
  List<Line>? lines;
  List<Link> links;

  Pto({
    required this.pagination,
    required this.feedPublishers,
    required this.context,
    this.stopAreas,
    this.lines,
    required this.links,
  });

  factory Pto.fromJson(Map<String, dynamic> json) => Pto(
    pagination: Pagination.fromJson(json["pagination"]),
    feedPublishers: List<FeedPublisher>.from(json["feed_publishers"].map((x) => FeedPublisher.fromJson(x))),
    context: Context.fromJson(json["context"]),
    stopAreas: json["stop_areas"] == null ? [] : List<StopArea>.from(json["stop_areas"]!.map((x) => StopArea.fromJson(x))),
    lines: json["lines"] == null ? [] : List<Line>.from(json["lines"]!.map((x) => Line.fromJson(x))),
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
    "feed_publishers": List<dynamic>.from(feedPublishers.map((x) => x.toJson())),
    "context": context.toJson(),
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Context {
  String currentDatetime;
  String timezone;

  Context({
    required this.currentDatetime,
    required this.timezone,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
    currentDatetime: json["current_datetime"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "current_datetime": currentDatetime,
    "timezone": timezone,
  };
}

class FeedPublisher {
  String id;
  String name;
  String url;
  String license;

  FeedPublisher({
    required this.id,
    required this.name,
    required this.url,
    required this.license,
  });

  factory FeedPublisher.fromJson(Map<String, dynamic> json) => FeedPublisher(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    license: json["license"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "license": license,
  };
}

class Link {
  String href;
  bool templated;
  String? rel;
  String type;

  Link({
    required this.href,
    required this.templated,
    this.rel,
    required this.type,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    href: json["href"],
    templated: json["templated"],
    rel: json["rel"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
    "templated": templated,
    "rel": rel,
    "type": type,
  };
}

class Pagination {
  int totalResult;
  int startPage;
  int itemsPerPage;
  int itemsOnPage;

  Pagination({
    required this.totalResult,
    required this.startPage,
    required this.itemsPerPage,
    required this.itemsOnPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalResult: json["total_result"],
    startPage: json["start_page"],
    itemsPerPage: json["items_per_page"],
    itemsOnPage: json["items_on_page"],
  );

  Map<String, dynamic> toJson() => {
    "total_result": totalResult,
    "start_page": startPage,
    "items_per_page": itemsPerPage,
    "items_on_page": itemsOnPage,
  };
}
