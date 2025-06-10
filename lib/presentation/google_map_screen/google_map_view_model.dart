import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/domain/use_case/google_map_use_case.dart';
import 'google_map_state.dart';
import 'package:gupae/core/utils/permission_utils.dart';

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
  Future<LatLng?> getMyLocation() async {
    final isGranted = await PermissionUtils.requestLocationPermission();
    if (!isGranted) {
      print('⚠️ 위치 권한 없음 확인바람');
      return null;
    }

    try {
      final position = await _useCase.getCurrentLocation();
      return position;
    } catch (e) {
      print('⚠️ 위치 가져오기 실패: $e');
      return null;
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
    final subwayToilets = _useCase.getNearbySubwayToilets(center, 500);
    final publicToilets = _useCase.getNearbyPublicToilets(center, 500);

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
