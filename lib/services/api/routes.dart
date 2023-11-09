import 'dart:convert';

import 'package:http/http.dart' as http;

class RouteAPI {
  static String url =
      //  'https://api.mapbox.com/directions/v5/mapbox/driving/19.24,73.12;19.30,73.10?geometries=geojson&access_token=pk.eyJ1IjoibXJ1bmFsMTIzNDU2Nzg5IiwiYSI6ImNsbWhzbWF2cTBzajAzcXIybTVoa3g1anQifQ.66Fu05Ii8-NVd-w-C-FSgA';
      'https://api.openrouteservice.org/v2/directions/driving-car';
  static String apiKey =
      '5b3ce3597851110001cf6248a48f8edf67d04599b4f01fac045d12c2';

  static Future<dynamic> getRoute(String startPoint, String endPoint) async {
    final res = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248a48f8edf67d04599b4f01fac045d12c2&start=8.681495,49.41461&end=8.687872,49.420318'));
    print(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248a48f8edf67d04599b4f01fac045d12c2&start=$startPoint&end=$endPoint');
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to load route');
    }
  }
}
