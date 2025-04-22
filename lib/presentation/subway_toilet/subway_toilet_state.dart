
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/model/subway/subway_toilet.dart';

part 'subway_toilet_state.freezed.dart';

part 'subway_toilet_state.g.dart';

@freezed
abstract class SubwayToiletState with _$SubwayToiletState {
  const factory SubwayToiletState({
    @Default([]) List<SubwayToilet> toilets,
    @JsonKey(ignore: true) @Default(<Marker>{}) Set<Marker> markers,
    @Default(false) bool isLoading,
    String? error,
  }) = _SubwayToiletState;

  factory SubwayToiletState.fromJson(Map<String, Object?> json) => _$SubwayToiletStateFromJson(json);
}