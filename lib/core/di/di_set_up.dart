

import 'package:get_it/get_it.dart';
import 'package:gupae/data/data_source/location/location_data_source.dart';
import 'package:gupae/data/data_source/location/location_data_source_impl.dart';
import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source.dart';
import 'package:gupae/data/data_source/public_seoul/public_toilet_data_source_impl.dart';
import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source.dart';
import 'package:gupae/data/data_source/subway_toilet/subway_toilet_data_source_impl.dart';
import 'package:gupae/domain/repository/location/location_repository.dart';
import 'package:gupae/domain/repository/location/location_repository_impl.dart';
import 'package:gupae/domain/repository/public/public_toilet_repository.dart';
import 'package:gupae/domain/repository/public/public_toilet_repository_impl.dart';
import 'package:gupae/domain/use_case/google_map_use_case.dart';
import 'package:gupae/domain/use_case/location/get_location_use_case.dart';
import 'package:gupae/domain/use_case/subway/get_subway_toilet_use_case.dart';
import 'package:gupae/presentation/google_map_screen/google_map_view_model.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:gupae/presentation/subway_toilet/subway_toilet_view_model.dart';

import '../../domain/repository/subway/subway_toilet_repository.dart';
import '../../domain/repository/subway/subway_toilet_repository_impl.dart';


final getIt = GetIt.instance;

void diSetUp() {
  getIt.registerSingleton<LocationDataSource>(LocationDataSourceImpl());
  getIt.registerSingleton<SubwayToiletDataSource>(SubwayToiletDataSourceImpl());
  getIt.registerSingleton<PublicToiletDataSource>(PublicToiletDataSourceImpl());

  getIt.registerSingleton<LocationRepository>(LocationRepositoryImpl(getIt()));
  getIt.registerSingleton<SubwayToiletRepository>(SubwayToiletRepositoryImpl(getIt()));
  getIt.registerSingleton<PublicToiletRepository>(PublicToiletRepositoryImpl(getIt()));

  getIt.registerSingleton(GetLocationUseCase(getIt()));
  getIt.registerSingleton(GetSubwayToiletUseCase(getIt()));
  getIt.registerSingleton(GetGoogleMapUseCase(subwayRepository: getIt(), publicRepository: getIt(), locationRepository: getIt()));
  
  getIt.registerFactory<LocationViewModel>(() => LocationViewModel(getIt()));
  getIt.registerFactory<SubwayToiletViewModle>(() => SubwayToiletViewModle(getIt()));
  getIt.registerFactory<GoogleMapViewModel>(() => GoogleMapViewModel(getIt()));

}