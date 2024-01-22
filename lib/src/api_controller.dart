import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gare_connect/src/api_constants.dart';
import 'package:http/http.dart' as http;

import 'model/pto_auto_model.dart';
import 'model/pto_model.dart';

class ApiController {
  late final String basicAuth;

  ApiController() {
    var username = dotenv.env[ApiConstants.usernameEnvLabel];
    var password = dotenv.env[ApiConstants.passwordEnvLabel];

    basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
  }

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

  Future<Pto?> getStopAreasByExactName(http.Client http, String name, {int depth = 1}) async {
    try {
      if (name.isEmpty) {
        // Si le nom est vide, lancer une exception
        throw Exception('Le nom renseigné est vide');
      }

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

  Future<PtoAuto?> getPtoAutocomplete(http.Client http, String searchKey,
      String? objectType, {int depth = 1}) async {
    try {
      var url = Uri.https(ApiConstants.baseUrl, '${ApiConstants.baseUrlVersion}${ApiConstants.coverage}/${ApiConstants.regionId}${ApiConstants.pt_objects}',
      {
        'q': searchKey,
        'type': objectType,
        'depth': depth.toString()
      });
      final response =
          await http.get(url, headers: {'Authorization': basicAuth});

      if (response.statusCode == 200) {
        // Si la requête a réussi, décoder les données JSON
        var data = json.decode(response.body);
        return PtoAuto.fromJson(data);
      } else {
        // Si la requête a échoué, lancer une exception avec le statut de réponse
        throw Exception('Échec de la requête, statut ${response.statusCode}');
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou autres
      throw Exception('Erreur lors de la requête : $e');
    }
  }

  //TODO: Faire plusieurs controller et garder celui la en APIM
}
