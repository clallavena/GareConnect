import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gare_connect/src/controllers/pto_controller.dart';
import 'package:gare_connect/src/model/pto_auto_model.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main(){
  var responseJson = '{"feed_publishers":[{"id":"sncf","name":"SNCF PIV Production","url":"","license":"Private (unspecified)"},{"id":"SNCF:sncf-piv","name":"SNCF PIV Production","url":"","license":"Private (unspecified)"}],"disruptions":[],"pt_objects":[{"id":"stop_area:SNCF:87746008","name":"Annecy (Annecy)","quality":100,"stop_area":{"id":"stop_area:SNCF:87746008","name":"Annecy","codes":[{"type":"source","value":"87746008"},{"type":"uic","value":"87746008"}],"timezone":"Europe/Paris","label":"Annecy (Annecy)","coord":{"lon":"6.121826","lat":"45.902047"},"links":[],"administrative_regions":[{"id":"admin:fr:74010","name":"Annecy","level":8,"zip_code":"74000;74960","label":"Annecy (74000-74960)","insee":"74010","coord":{"lon":"6.1288847","lat":"45.8992348"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87745497","name":"Annemasse (Annemasse)","quality":100,"stop_area":{"id":"stop_area:SNCF:87745497","name":"Annemasse","codes":[{"type":"source","value":"87745497"},{"type":"uic","value":"87745497"}],"timezone":"Europe/Paris","label":"Annemasse (Annemasse)","coord":{"lon":"6.236431","lat":"46.199245"},"links":[],"administrative_regions":[{"id":"admin:fr:74012","name":"Annemasse","level":8,"zip_code":"74100","label":"Annemasse (74100)","insee":"74012","coord":{"lon":"6.2341093","lat":"46.1934005"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87746206","name":"Pringy (Annecy)","quality":90,"stop_area":{"id":"stop_area:SNCF:87746206","name":"Pringy","codes":[{"type":"source","value":"87746206"},{"type":"uic","value":"87746206"}],"timezone":"Europe/Paris","label":"Pringy (Annecy)","coord":{"lon":"6.123338","lat":"45.939517"},"links":[],"administrative_regions":[{"id":"admin:fr:74010","name":"Annecy","level":8,"zip_code":"74000;74960","label":"Annecy (74000-74960)","insee":"74010","coord":{"lon":"6.1288847","lat":"45.8992348"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87272195","name":"Longueil-Annel (Longueil-Annel)","quality":90,"stop_area":{"id":"stop_area:SNCF:87272195","name":"Longueil-Annel","codes":[{"type":"source","value":"87272195"},{"type":"uic","value":"87272195"}],"timezone":"Europe/Paris","label":"Longueil-Annel (Longueil-Annel)","coord":{"lon":"2.862877","lat":"49.466991"},"links":[],"administrative_regions":[{"id":"admin:fr:60368","name":"Longueil-Annel","level":8,"zip_code":"60150","label":"Longueil-Annel (60150)","insee":"60368","coord":{"lon":"2.863719","lat":"49.469411"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87286856","name":"Annappes (Villeneuve-d\'Ascq)","quality":80,"stop_area":{"id":"stop_area:SNCF:87286856","name":"Annappes","codes":[{"type":"source","value":"87286856"},{"type":"uic","value":"87286856"}],"timezone":"Europe/Paris","label":"Annappes (Villeneuve-d\'Ascq)","coord":{"lon":"3.14629","lat":"50.622807"},"links":[],"administrative_regions":[{"id":"admin:fr:59009","name":"Villeneuve-d\'Ascq","level":8,"zip_code":"59491;59650","label":"Villeneuve-d\'Ascq (59491-59650)","insee":"59009","coord":{"lon":"3.1314002","lat":"50.6193174"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87365155","name":"Annonay Boutique SNCF (Annonay)","quality":80,"stop_area":{"id":"stop_area:SNCF:87365155","name":"Annonay Boutique SNCF","codes":[{"type":"source","value":"87365155"},{"type":"uic","value":"87365155"}],"timezone":"Europe/Paris","label":"Annonay Boutique SNCF (Annonay)","coord":{"lon":"4.675772","lat":"45.246458"},"links":[],"administrative_regions":[{"id":"admin:fr:07010","name":"Annonay","level":8,"zip_code":"07100","label":"Annonay (07100)","insee":"07010","coord":{"lon":"4.6675475","lat":"45.2399639"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87761270","name":"Annonay-Gare Routière (Annonay)","quality":70,"stop_area":{"id":"stop_area:SNCF:87761270","name":"Annonay-Gare Routière","codes":[{"type":"source","value":"87761270"},{"type":"uic","value":"87761270"}],"timezone":"Europe/Paris","label":"Annonay-Gare Routière (Annonay)","coord":{"lon":"4.66863","lat":"45.24373"},"links":[],"administrative_regions":[{"id":"admin:fr:07010","name":"Annonay","level":8,"zip_code":"07100","label":"Annonay (07100)","insee":"07010","coord":{"lon":"4.6675475","lat":"45.2399639"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87476648","name":"Sainte-Anne (Pluneret)","quality":70,"stop_area":{"id":"stop_area:SNCF:87476648","name":"Sainte-Anne","codes":[{"type":"source","value":"87476648"},{"type":"uic","value":"87476648"}],"timezone":"Europe/Paris","label":"Sainte-Anne (Pluneret)","coord":{"lon":"-2.960609","lat":"47.678545"},"links":[],"administrative_regions":[{"id":"admin:fr:56176","name":"Pluneret","level":8,"zip_code":"56400","label":"Pluneret (56400)","insee":"56176","coord":{"lon":"-2.9571398","lat":"47.6756752"}}]},"embedded_type":"stop_area"},{"id":"stop_area:SNCF:87640714","name":"Couiza - Saint-Anne (Couiza)","quality":70,"stop_area":{"id":"stop_area:SNCF:87640714","name":"Couiza - Saint-Anne","codes":[{"type":"source","value":"87640714"},{"type":"uic","value":"87640714"}],"timezone":"Europe/Paris","label":"Couiza - Saint-Anne (Couiza)","coord":{"lon":"2.253746","lat":"42.941324"},"links":[],"administrative_regions":[{"id":"admin:fr:11103","name":"Couiza","level":8,"zip_code":"11190","label":"Couiza (11190)","insee":"11103","coord":{"lon":"2.2544139","lat":"42.9421253"}}]},"embedded_type":"stop_area"},{"id":"line:SNCF:FR:Line::F4B0CFE6-18E1-4D06-A749-805E6E29BD07:","name":"TER Annecy - Chambery","quality":80,"line":{"id":"line:SNCF:FR:Line::F4B0CFE6-18E1-4D06-A749-805E6E29BD07:","name":"Annecy - Chambery","code":"","color":"","text_color":"","codes":[],"physical_modes":[{"id":"physical_mode:Coach","name":"Autocar"},{"id":"physical_mode:Train","name":"TER / Intercités"}],"commercial_mode":{"id":"commercial_mode:TER","name":"TER"},"routes":[{"id":"route:SNCF:FR:Line::F4B0CFE6-18E1-4D06-A749-805E6E29BD07:","name":"Annecy - Chambery","is_frequence":"False","direction_type":"forward","direction":{"id":"stop_area:SNCF:87741009","name":"Chambéry - Challes-les-Eaux (Chambéry)","quality":0,"stop_area":{"id":"stop_area:SNCF:87741009","name":"Chambéry - Challes-les-Eaux","codes":[{"type":"source","value":"87741009"},{"type":"uic","value":"87741009"}],"timezone":"Europe/Paris","label":"Chambéry - Challes-les-Eaux (Chambéry)","coord":{"lon":"5.919547","lat":"45.571302"},"links":[]},"embedded_type":"stop_area"},"geojson":{"type":"MultiLineString","coordinates":[]},"links":[]}],"network":{"id":"network:SNCF:TER","name":"TER","links":[]},"opening_time":"062300","closing_time":"002200","geojson":{"type":"MultiLineString","coordinates":[]},"links":[]},"embedded_type":"line"}],"context":{"current_datetime":"20240129T223447","timezone":"Europe/Paris"},"links":[{"href":"https://api.sncf.com/v1/coverage/sncf/stop_areas/{stop_area.id}","templated":true,"rel":"stop_areas","type":"stop_area"},{"href":"https://api.sncf.com/v1/coverage/sncf/routes/{routes.id}","templated":true,"rel":"routes","type":"routes"},{"href":"https://api.sncf.com/v1/coverage/sncf/networks/{network.id}","templated":true,"rel":"networks","type":"network"},{"href":"https://api.sncf.com/v1/coverage/sncf/lines/{line.id}","templated":true,"rel":"lines","type":"line"},{"href":"https://api.sncf.com/v1/coverage/sncf/commercial_modes/{commercial_mode.id}","templated":true,"rel":"commercial_modes","type":"commercial_mode"},{"href":"https://api.sncf.com/v1/coverage/sncf/physical_modes/{physical_modes.id}","templated":true,"rel":"physical_modes","type":"physical_modes"}]}';
  dotenv.testLoad(fileInput: File('.env').readAsStringSync());
  var responsePto = PtoAuto.fromJson(jsonDecode(responseJson));

  setUp(() {
    registerFallbackValue(FakeUri()); // Required by Mocktail
  });

  group('GetPtoAutoComplete', () {
    final client = MockClient();
    final ptoController = PtoController("");

    test('getPtoAutoComplete - Successful Response', () async {
      // Simuler une réponse HTTP réussie
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(((_) async {
        return http.Response(responseJson, 200);
      }));

      when(() => ptoController.getPtoAutocomplete(client, any(), any(), depth: any(named: "depth"))).thenAnswer(((_) async {
        return responsePto;
      }));

      // Vérifier que le résultat est du type Pto et contient les données décodées
      // avec des valeurs aléatoires dans les propriétés de la méthode
      expect(await ptoController.getPtoAutocomplete(client, "", "", depth: 1), isA<PtoAuto>());
    });

    test('getPtoAutoComplete - Failed Response', () async {
      // Simuler une réponse HTTP avec un statut d'erreur
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(((_) async {
        return http.Response('Error', 404);
      }));

      when(() => ptoController.getPtoAutocomplete(client, any(), any())).thenAnswer(((_) async {
        return responsePto;
      }));

      // Appeler la méthode à tester et vérifier qu'elle lève une exception
      expect(await ptoController.getPtoAutocomplete(client, "", ""), throwsException);
    });
  });
}
