import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract interface class LocationDataSource {
  Future<LatLng> getCurrentLocation();
}