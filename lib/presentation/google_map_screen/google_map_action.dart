import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_map_action.freezed.dart';

@freezed
sealed class GoogleMapAction with _$GoogleMapAction {
  const factory GoogleMapAction.onMapCreated(GoogleMapController controller) = OnMapCreated;
  const factory GoogleMapAction.onCurrentLocationTap() = OnCurrentLocationTap;
  const factory GoogleMapAction.onCameraMove(CameraPosition position) = OnCameraMove;
  const factory GoogleMapAction.onCameraIdle() = OnCameraIdle;
}