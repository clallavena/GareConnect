import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gare_connect/src/controllers/interfaces/pto_interface.dart';
import 'package:gare_connect/src/controllers/interfaces/stop_areas_interface.dart';
import 'package:gare_connect/src/controllers/pto_controller.dart';
import 'package:gare_connect/src/controllers/stop_areas_controller.dart';
import 'package:gare_connect/src/utils/api_constants.dart';
import 'package:http/http.dart' as http;

import '../model/pto_auto_model.dart';
import '../model/pto_model.dart';

class ApiController {
  late final String basicAuth;
  late final PtoAutoComplete ptoController;
  late final StopAreasInterface stopAreasController;

  ApiController() {
    var username = dotenv.env[ApiConstants.usernameEnvLabel];
    var password = dotenv.env[ApiConstants.passwordEnvLabel];

    basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    ptoController = PtoController(basicAuth);
    stopAreasController = StopAreasController(basicAuth);
  }

  Future<Pto?> getStopAreas(http.Client http) async {
    try {
      return await stopAreasController.getStopAreas(http);
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
      return await stopAreasController.getStopAreasByExactName(http, name, depth: depth);
    } catch (e) {
      // Gérer les erreurs de connexion ou autres
      throw Exception('Erreur lors de la requête : $e');
    }
  }

  Future<PtoAuto?> getPtoAutocomplete(http.Client http, String searchKey,
      String? objectType, {int depth = 1}) async {
    try {
      return await ptoController.getPtoAutocomplete(http, searchKey,
          objectType, depth: depth);
    } catch (e) {
      // Gérer les erreurs de connexion ou autres
      throw Exception('Erreur lors de la requête : $e');
    }
  }

  //TODO: Faire plusieurs controller et garder celui la en APIM
}
