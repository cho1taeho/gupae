
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/domain/repository/location/location_repository.dart';

class GetLocationUseCase {
  final LocationRepository _locationRepository;

  GetLocationUseCase(this._locationRepository);

  Future<LatLng> excute() async {
    return await _locationRepository.getCurrentLocation();
  }
}