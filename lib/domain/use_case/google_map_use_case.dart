import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;

import '../model/public/public_toilet.dart';
import '../model/subway/subway_toilet.dart';
import '../repository/public/public_toilet_repository.dart';
import '../repository/subway/subway_toilet_repository.dart';

class GetGoogleMapUseCase {
  final SubwayToiletRepository subwayRepository;
  final PublicToiletRepository publicRepository;

  List<SubwayToilet> _cachedSubwayToilets = [];
  List<PublicToilet> _cachedPublicToilets = [];

  GetGoogleMapUseCase({
    required this.subwayRepository,
    required this.publicRepository,
  });

  Future<void> loadAllToilets() async {
    _cachedSubwayToilets = await subwayRepository.getSubwayToilets();
    _cachedPublicToilets = await publicRepository.getPublicToilets();
  }

  List<SubwayToilet> getNearbySubwayToilets(LatLng center, double radiusMeters) {
    final centerPoint = toolkit.LatLng(center.latitude, center.longitude);
    return _cachedSubwayToilets.where((e) {
      final point = toolkit.LatLng(e.latitude, e.longitude);
      final distance = toolkit.SphericalUtil.computeDistanceBetween(centerPoint, point);
      return distance <= radiusMeters;
    }).toList();
  }

  List<PublicToilet> getNearbyPublicToilets(LatLng center, double radiusMeters) {
    final centerPoint = toolkit.LatLng(center.latitude, center.longitude);
    return _cachedPublicToilets.where((e) {
      final point = toolkit.LatLng(e.lat, e.lng);
      final distance = toolkit.SphericalUtil.computeDistanceBetween(centerPoint, point);
      return distance <= radiusMeters;
    }).toList();
  }
}