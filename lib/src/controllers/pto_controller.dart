import 'dart:convert';
import 'package:gare_connect/src/controllers/interfaces/pto_interface.dart';
import 'package:http/http.dart' as http;

import 'package:gare_connect/src/model/pto_auto_model.dart';
import 'package:gare_connect/src/utils/api_constants.dart';

class PtoController implements PtoAutoComplete{
  final String basicAuth;

  PtoController(this.basicAuth);

  @override
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
}