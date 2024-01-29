import 'dart:convert';

import 'package:gare_connect/src/controllers/interfaces/stop_areas_interface.dart';
import 'package:gare_connect/src/model/pto_model.dart';
import 'package:gare_connect/src/utils/api_constants.dart';
import 'package:http/http.dart' as http;

class StopAreasController implements StopAreasInterface {
  final String basicAuth;

  StopAreasController(this.basicAuth);

  @override
  Future<Pto?> getStopAreas(http.Client http) async {
    try {
      var url = Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.coverage}/${ApiConstants.regionId}${ApiConstants.stopArea}");
      final response =
          await http.get(url, headers: {'Authorization': basicAuth});

      if (response.statusCode == 200) {
        // Si la requête a réussi, décoder les données JSON
        var data = json.decode(response.body);
        return Pto.fromJson(data);
      } else {
        // Si la requête a échoué, lancer une exception avec le statut de réponse
        throw Exception('Échec de la requête, statut ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou autres
      throw Exception('Erreur lors de la requête : $e');
    }
  }

  @override
  Future<Pto?> getStopAreasByExactName(http.Client http, String name, {int depth = 1}) async {
    try {
      var filter = 'stop_area.name("$name")';
      var url = Uri.https(ApiConstants.baseUrl, '${ApiConstants.baseUrlVersion}${ApiConstants.coverage}/${ApiConstants.regionId}${ApiConstants.stopArea}',
          {
            'filter': filter,
            'depth': depth.toString()
          });
      final response =
      await http.get(url, headers: {'Authorization': basicAuth});

      if (response.statusCode == 200) {
        // Si la requête a réussi, décoder les données JSON
        var data = json.decode(response.body);
        return Pto.fromJson(data);
      } else {
        // Si la requête a échoué, lancer une exception avec le statut de réponse
        throw Exception('Échec de la requête, statut ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou autres
      throw Exception('Erreur lors de la requête : $e');
    }
  }

}
