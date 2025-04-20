

import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:gupae/data/data_source/location/location_data_source.dart';
import 'package:gupae/domain/repository/location/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource _locationDataSource;

  LocationRepositoryImpl(this._locationDataSource);

  @override
  Future<LatLng> getCurrentLocation() {
    return _locationDataSource.getCurrentLocation();
  }
}