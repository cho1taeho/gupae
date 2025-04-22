

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/subway_toilet/subway_toilet_state.dart';

import '../../domain/use_case/subway/get_subway_toilet_use_case.dart';

class SubwayToiletViewModle with ChangeNotifier {
  final GetSubwayToiletUseCase _getSubwayToiletUseCase;

  SubwayToiletViewModle(this._getSubwayToiletUseCase);

  SubwayToiletState _state = SubwayToiletState();
  SubwayToiletState get state => _state;


  Future<void> fetchSubwayToiletLocation(LatLng currentLocation) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final toilets = await _getSubwayToiletUseCase.execute(currentLocation);
    final List<Marker> resultMarkers = [];

    for (final toilet in toilets) {
      final marker = Marker(
        markerId: MarkerId('${toilet.stationName}_${toilet.latitude}_${toilet.longitude}'),
        position: LatLng(toilet.latitude, toilet.longitude),
        infoWindow: InfoWindow(title: toilet.stationName),
        icon:  BitmapDescriptor.defaultMarkerWithHue(
          toilet.isOutsideGate
              ? BitmapDescriptor.hueBlue
              : BitmapDescriptor.hueRed
        )
      );
      resultMarkers.add(marker);
    }
    _state = state.copyWith(markers: resultMarkers.toSet());
    _state = state.copyWith(isLoading: false);
    notifyListeners();
  }
}
