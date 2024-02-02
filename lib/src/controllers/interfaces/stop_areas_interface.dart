import 'package:gare_connect/src/model/pto_model.dart';
import 'package:http/http.dart' as http;

abstract class StopAreasInterface{
  /// Used to get all stop areas available.
  Future<Pto?> getStopAreas(http.Client http);
  /// Used to get stop areas with its exact name
  Future<Pto?> getStopAreasByExactName(http.Client http, String name, {int depth = 1});
}