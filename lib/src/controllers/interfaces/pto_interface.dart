import 'package:gare_connect/src/model/pto_auto_model.dart';
import 'package:http/http.dart' as http;

abstract class PtoAutoComplete {
  Future<PtoAuto?> getPtoAutocomplete(http.Client http, String searchKey, String? objectType, {int depth = 1});
}