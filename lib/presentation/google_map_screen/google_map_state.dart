import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/model/public/public_toilet.dart';
import '../../domain/model/subway/subway_toilet.dart';

part 'google_map_state.freezed.dart';

part 'google_map_state.g.dart';

@freezed
abstract class GoogleMapState with _$GoogleMapState {
  const factory GoogleMapState({
    @JsonKey(ignore: true) LatLng? currentLocation,
    @Default(false) bool isLoading,
    String? error,

    @Default(<SubwayToilet>[]) List<SubwayToilet> subwayToilets,
    @Default(<PublicToilet>[]) List<PublicToilet> publicToilets,

    @JsonKey(ignore: true) @Default(<Marker>{}) Set<Marker> markers,
  }) = _GoogleMapState;
  
  factory GoogleMapState.fromJson(Map<String, Object?> json) => _$GoogleMapStateFromJson(json); 
}