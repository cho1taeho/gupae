
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;
import 'package:gupae/domain/model/subway/subway_toilet.dart';
import 'package:gupae/domain/repository/subway_repository/subway_toilet_repository.dart';

class GetSubwayToiletUseCase {
  final SubwayToiletRepository _subwayToiletRepository;

  GetSubwayToiletUseCase(this._subwayToiletRepository);

  Future<List<SubwayToilet>> execute(gmap.LatLng currentLocation) async {
    final toilets = await _subwayToiletRepository.getSubwayToilets();
    final currentPoint = toolkit.LatLng(currentLocation.latitude, currentLocation.longitude);

    return toilets.where((e) {
      final toiletPoint = toolkit.LatLng(e.latitude, e.longitude);
      final distance = toolkit.SphericalUtil.computeDistanceBetween(currentPoint, toiletPoint);

      return distance <= 1000.0;
    }).toList();
  }
}