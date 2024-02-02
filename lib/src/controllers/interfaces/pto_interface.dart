import 'package:gare_connect/src/model/pto_auto_model.dart';
import 'package:http/http.dart' as http;

abstract class PtoAutoComplete {
  /// This method is used to search a pto object with a searchkey.
  /// It's possible to search any kind of object by using the object type.
  Future<PtoAuto?> getPtoAutocomplete(http.Client http, String searchKey, String? objectType, {int depth = 1});
}