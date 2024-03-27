import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final double neBoundsLat;
  final double neBoundsLng;
  final double swBoundsLat;
  final double swBoundsLng;
  final String overviewPolylinePoints;

  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final double totalDistanceValue;
  final String totalDuration;

  const Directions({
    required this.neBoundsLat,
    required this.neBoundsLng,
    required this.swBoundsLat,
    required this.swBoundsLng,
    required this.overviewPolylinePoints,
    required this.bounds,
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDistanceValue,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    // Bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    final neBoundsLat = data['bounds']['northeast']['lat'];
    final neBoundsLng = data['bounds']['northeast']['lng'];
    final swBoundsLat = data['bounds']['southwest']['lat'];
    final swBoundsLng = data['bounds']['southwest']['lng'];

    // Distance & Duration
    String distance = '';
    String duration = '';
    double distanceValue = 0;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      distanceValue = leg['distance']['value'] / 1000;
      duration = leg['duration']['text'];
    }

    final overviewPolylinePoints = data['overview_polyline']['points'];

    return Directions(
      neBoundsLat: neBoundsLat,
      neBoundsLng: neBoundsLng,
      swBoundsLat: swBoundsLat,
      swBoundsLng: swBoundsLng,
      overviewPolylinePoints: overviewPolylinePoints,
      bounds: bounds,
      polylinePoints:
      PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDistanceValue: distanceValue,
      totalDuration: duration,
    );
  }
}
