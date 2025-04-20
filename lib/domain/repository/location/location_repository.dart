import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract interface class LocationRepository {
  Future<LatLng> getCurrentLocation();
}