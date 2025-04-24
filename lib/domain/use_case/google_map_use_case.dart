import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;
import 'package:gupae/domain/repository/location/location_repository.dart';

import '../model/public/public_toilet.dart';
import '../model/subway/subway_toilet.dart';
import '../repository/public/public_toilet_repository.dart';
import '../repository/subway/subway_toilet_repository.dart';

class GetGoogleMapUseCase {
  final LocationRepository locationRepository;
  final SubwayToiletRepository subwayRepository;
  final PublicToiletRepository publicRepository;

  GetGoogleMapUseCase({
    required this.locationRepository,
    required this.subwayRepository,
    required this.publicRepository,
  });

  Future<LatLng?> getCurrentLocation() async {
    return await locationRepository.getCurrentLocation();
  }

  Future<List<SubwayToilet>> getNearbySubwayToilets(LatLng current) async {
    final allToilets = await subwayRepository.getSubwayToilets();
    final currentPoint = toolkit.LatLng(current.latitude, current.longitude);

    return allToilets.where((e) {
      final toiletPoint = toolkit.LatLng(e.latitude, e.longitude);
      final distance = toolkit.SphericalUtil.computeDistanceBetween(currentPoint, toiletPoint);
      return distance <= 1000.0;
    }).toList();
  }

  Future<List<PublicToilet>> getNearbyPublicToilets(LatLng current) async {
    final allToilets = await publicRepository.getPublicToilets();
    final currentPoint = toolkit.LatLng(current.latitude, current.longitude);

    return allToilets.where((e) {
      final toiletPoint = toolkit.LatLng(e.lat, e.lng);
      final distance = toolkit.SphericalUtil.computeDistanceBetween(currentPoint, toiletPoint);
      return distance <= 1000.0;
    }).toList();
  }
}
