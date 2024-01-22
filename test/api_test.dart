import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gare_connect/src/api_controller.dart';
import 'package:gare_connect/src/model/pto_model.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main(){
  var responseJson = '{"pagination":{"total_result":1,"start_page":0,"items_per_page":25,"items_on_page":1},"feed_publishers":[{"id":"sncf","name":"SNCF PIV Production","url":"","license":"Private (unspecified)"},{"id":"SNCF:sncf-piv","name":"SNCF PIV Production","url":"","license":"Private (unspecified)"}],"disruptions":[],"context":{"current_datetime":"20240108T232328","timezone":"Europe\/Paris"},"stop_areas":[{"id":"stop_area:SNCF:87746008","name":"Annecy","codes":[{"type":"source","value":"87746008"},{"type":"uic","value":"87746008"}],"timezone":"Europe\/Paris","label":"Annecy (Annecy)","coord":{"lon":"6.121826","lat":"45.902047"},"links":[],"administrative_regions":[{"id":"admin:fr:74010","name":"Annecy","level":8,"zip_code":"74000;74960","label":"Annecy (74000-74960)","insee":"74010","coord":{"lon":"6.1288847","lat":"45.8992348"}}]}],"links":[{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}","templated":true,"rel":"stop_areas","type":"stop_areas"},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/route_schedules","rel":"route_schedules","type":"route_schedules","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/stop_schedules","rel":"stop_schedules","type":"stop_schedules","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/arrivals","rel":"arrivals","type":"arrivals","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/departures","rel":"departures","type":"departures","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/places_nearby","rel":"places_nearby","type":"places_nearby","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/journeys","rel":"journeys","type":"journey","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas\/{stop_areas.id}\/traffic_reports","rel":"disruptions","type":"disruption","templated":true},{"href":"https:\/\/api.sncf.com\/v1\/coverage\/sncf\/stop_areas?filter=stop_area.name%28%22Annecy%22%29","type":"first","templated":false}]}';
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());

  setUp(() {
    registerFallbackValue(FakeUri()); // Required by Mocktail
  });

  group('GetStopAreas', () {
    final client = MockClient();
    final apiController = ApiController();

    test('getStopAreas - Successful Response', () async {
      // Simuler une réponse HTTP réussie
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(((_) async {
        return http.Response(responseJson, 200);
      }));
      // Vérifier que le résultat est du type Pto et contient les données décodées
      expect(await apiController.getStopAreas(client), isA<Pto>());
      //expect(result?.example, "data");
    });

    test('getStopAreas - Failed Response', () {
      // Simuler une réponse HTTP avec un statut d'erreur
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(((_) async {
        return http.Response('Error', 404);
      }));

      // Appeler la méthode à tester et vérifier qu'elle lève une exception
      expect(apiController.getStopAreas(client), throwsException);
    });
  });

  group('GetStopAreasByExactName', () {
    final client = MockClient();
    final apiController = ApiController();

    test('getStopAreasByExactName - Successful Response', () async {
      // Simuler une réponse HTTP réussie
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(((_) async {
        return http.Response(responseJson, 200);
      }));

      // Vérifier que le résultat est du type Pto et contient les données décodées
      expect(await apiController.getStopAreasByExactName(client, "Annecy"), isA<Pto>());
      //expect(result?.example, "data");
    });
  });
}
