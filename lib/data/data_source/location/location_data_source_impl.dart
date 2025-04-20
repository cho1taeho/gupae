
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gupae/data/data_source/location/location_data_source.dart';


class LocationDataSoruceImpl implements LocationDataSource {
  @override
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('LocationDataSource : 실패');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw Exception('위치 권한 거부');
      }
    }
    final position = await Geolocator.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }
}