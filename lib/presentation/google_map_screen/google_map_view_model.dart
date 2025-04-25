import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/domain/use_case/google_map_use_case.dart';
import 'google_map_state.dart';

class GoogleMapViewModel with ChangeNotifier {
  final GetGoogleMapUseCase _useCase;

  GoogleMapViewModel(this._useCase);

  GoogleMapState _state = const GoogleMapState();
  GoogleMapState get state => _state;

  Future<void> initialize(LatLng center) async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await _useCase.loadAllToilets();
      _loadToiletsAt(center);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
      notifyListeners();
    }
  }

  void setCenter(LatLng center) {
    if (_state.currentLocation != center) {
      _state = _state.copyWith(currentLocation: center);
      notifyListeners();
    }
  }

  void refreshToiletsAtCenter() {
    final center = _state.currentLocation;
    if (center == null) {
      print('⚠️ 중심 위치 없음');
      return;
    }

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    _loadToiletsAt(center);
  }

  void _loadToiletsAt(LatLng center) {
    final subwayToilets = _useCase.getNearbySubwayToilets(center, 2000);
    final publicToilets = _useCase.getNearbyPublicToilets(center, 2000);

    final markers = <Marker>[
      ...subwayToilets.map((t) => Marker(
        markerId: MarkerId('subway_${t.stationName}'),
        position: LatLng(t.latitude, t.longitude),
        infoWindow: InfoWindow(title: '${t.stationName}역 화장실'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          t.isOutsideGate ? BitmapDescriptor.hueBlue : BitmapDescriptor.hueRed,
        ),
      )),
      ...publicToilets.map((t) => Marker(
        markerId: MarkerId('public_${t.name}'),
        position: LatLng(t.lat, t.lng),
        infoWindow: InfoWindow(title: t.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      )),
    ];

    _state = _state.copyWith(
      subwayToilets: subwayToilets,
      publicToilets: publicToilets,
      markers: markers.toSet(),
      isLoading: false,
      noResult: subwayToilets.isEmpty && publicToilets.isEmpty,
    );

    notifyListeners();
  }
}
