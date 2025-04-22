

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/domain/use_case/location/get_location_use_case.dart';
import 'package:gupae/presentation/location/location_state.dart';

class LocationViewModel with ChangeNotifier {
  final GetLocationUseCase _getLocationUseCase;


  LocationViewModel(this._getLocationUseCase);

  LocationState _state = LocationState(isLoading: false);

  LocationState get state => _state;

  Future<void> fetchCurrentLocation() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final LatLng location = await _getLocationUseCase.excute();
      _state = _state.copyWith(currentLocation: location, isLoading: false);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    }

    notifyListeners();
  }

}