

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.freezed.dart';

part 'location_state.g.dart';

LatLng? _latLngFromJson(Map<String, dynamic>? json) =>
    json == null ? null : LatLng(json['lat'] as double, json['lng'] as double);

Map<String, dynamic>? _latLngToJson(LatLng? latLng) =>
    latLng == null ? null : {'lat': latLng.latitude, 'lng': latLng.longitude};


@freezed
abstract class LocationState with _$LocationState {
  const factory LocationState({
    @JsonKey(fromJson: _latLngFromJson, toJson: _latLngToJson)
    LatLng? currentLocation,
    required bool isLoading,
    String? error,
  }) = _LocationState;

  factory LocationState.fromJson(Map<String, Object?> json) => _$LocationStateFromJson(json);
}