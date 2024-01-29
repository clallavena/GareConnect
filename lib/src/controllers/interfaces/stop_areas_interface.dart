import 'package:gare_connect/src/model/pto_model.dart';
import 'package:http/http.dart' as http;

abstract class StopAreasInterface{
  Future<Pto?> getStopAreas(http.Client http);
  Future<Pto?> getStopAreasByExactName(http.Client http, String name, {int depth = 1});
}