import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/domain/use_case/google_map_use_case.dart';
import 'package:gupae/presentation/google_map_screen/google_map_state.dart';

class GoogleMapViewModel with ChangeNotifier {
  final GetGoogleMapUseCase _googleMapUseCase;

  GoogleMapViewModel(this._googleMapUseCase);

  GoogleMapState _state = const GoogleMapState();
  GoogleMapState get state => _state;

  Future<void> fetchMapData() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final current = await _googleMapUseCase.getCurrentLocation();
      if (current == null) {
        throw Exception('현재 위치를 가져올 수 없습니다.');
      }

      final subwayToilets = await _googleMapUseCase.getNearbySubwayToilets(current);
      final publicToilets = await _googleMapUseCase.getNearbyPublicToilets(current);

      final List<Marker> resultMarkers = [];

      for (final toilet in subwayToilets) {
        resultMarkers.add(
          Marker(
            markerId: MarkerId('subway_${toilet.stationName}_${toilet.latitude}_${toilet.longitude}'),
            position: LatLng(toilet.latitude, toilet.longitude),
            infoWindow: InfoWindow(title: '${toilet.stationName}역 화장실'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              toilet.isOutsideGate ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed,
            ),
          ),
        );
      }

      for (final toilet in publicToilets) {
        resultMarkers.add(
          Marker(
            markerId: MarkerId('public_${toilet.name}_${toilet.lat}_${toilet.lng}'),
            position: LatLng(toilet.lat, toilet.lng),
            infoWindow: InfoWindow(title: toilet.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      }

      _state = _state.copyWith(
        currentLocation: current,
        subwayToilets: subwayToilets,
        publicToilets: publicToilets,
        markers: resultMarkers.toSet(),
        isLoading: false,
        error: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }

    notifyListeners();
  }
}
