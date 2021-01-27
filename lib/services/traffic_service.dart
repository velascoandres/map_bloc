import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_bloc/models/geocoding_response.dart';
import 'package:map_bloc/models/traffic_response.dart';

class TrafficService {
  // Singleton
  TrafficService._privateContructor();

  static final TrafficService _instance = TrafficService._privateContructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();

  final baseUrl = 'https://api.mapbox.com/directions/v5';
  final baseUrlGeocoding = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey =
      'pk.eyJ1IjoidmVsYXNjb2FuZHJzIiwiYSI6ImNrZ3BncWE4ZjA5czUyenFxMmM1MTh2b2sifQ.o6faeXYecXpVa01RabAilQ';

  Future<DrivingResponse> getCoordsInicioYFin(LatLng inicio, LatLng destino) async {
    final coordsString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordsString';

    final resp = await this._dio.get(
      url,
      queryParameters: {
        'alternatives': 'true',
        'geometries': 'polyline6',
        'steps': 'false',
        'access_token': this._apiKey,
        'language': 'es',
      },
    );
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }



  Future<GeocodingResponse> obtenerDirecciones(String busqueda, LatLng proximidad) async {
      final url = '${this.baseUrlGeocoding}/mapbox.places/$busqueda.json';
      final resp = await this._dio.get(
      url,
      queryParameters: {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': '${proximidad.longitude},${proximidad.latitude}',
        'language': 'es',
      },
    );

    return geocodingResponseFromJson(resp.data);
  }

}
