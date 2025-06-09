
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source.dart';
import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source_impl.dart';
import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source.dart';
import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source_impl.dart';

import '../../data/data_source/location/location_data_source.dart';
import '../../data/data_source/location/location_data_source_impl.dart';
import '../../domain/repository/location/location_repository.dart';
import '../../domain/repository/location/location_repository_impl.dart';
import '../../domain/repository/public/public_toilet_repository.dart';
import '../../domain/repository/public/public_toilet_repository_impl.dart';
import '../../domain/repository/subway/subway_toilet_repository.dart';
import '../../domain/repository/subway/subway_toilet_repository_impl.dart';
import '../../domain/use_case/google_map_use_case.dart';
import '../../presentation/google_map_screen/google_map_view_model.dart';

final subwayDataSourceProvider = Provider<SubwayToiletDataSource>((ref) {
  return SubwayToiletDataSourceImpl();
});

final publicDataSourceProvider = Provider<PublicToiletDataSource>((ref) {
  return PublicToiletDataSourceImpl();
});

final locationDataSourceProvider = Provider<LocationDataSource>((ref) {
  return LocationDataSourceImpl();
});


final subwayRepoProvider = Provider<SubwayToiletRepository>((ref) {
  return SubwayToiletRepositoryImpl(ref.read(subwayDataSourceProvider));
});
final publicRepoProvider = Provider<PublicToiletRepository>((ref) {
  return PublicToiletRepositoryImpl(ref.read(publicDataSourceProvider));
});
final locationRepoProvider = Provider<LocationRepository>((ref) {
  return LocationRepositoryImpl(ref.read(locationDataSourceProvider));
});


final googleMapUseCaseProvider = Provider<GetGoogleMapUseCase>((ref) {
  return GetGoogleMapUseCase(
    subwayRepository: ref.read(subwayRepoProvider),
    publicRepository: ref.read(publicRepoProvider),
    locationRepository: ref.read(locationRepoProvider),
  );
});

final googleMapViewModelProvider =
ChangeNotifierProvider<GoogleMapViewModel>((ref) {
  return GoogleMapViewModel(ref.read(googleMapUseCaseProvider));
});