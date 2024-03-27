import 'package:bus_stop/config/google_maps/google_maps.dart';
import 'package:bus_stop/models/directions_model.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  var googleAPIKey = googleApiKey;

  final Dio _dio = Dio();

  Future<Directions?> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );

      return Directions.fromMap(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
