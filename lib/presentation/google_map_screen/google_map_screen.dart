

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:http/http.dart';

import '../../core/di/di_set_up.dart';
import 'google_map_action.dart';
import 'google_map_state.dart';

class GoogleMapScreen extends StatelessWidget {
  final GoogleMapState state;
  final void Function(GoogleMapAction action) onAction;

  const GoogleMapScreen({
    super.key,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    const LatLng defaultCenter = LatLng(36.5, 127.5);

    return Scaffold(
      appBar: AppBar(title: const Text('내 주변 화장실')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => onAction(GoogleMapAction.onMapCreated(controller)),
            initialCameraPosition: CameraPosition(
              target: state.currentLocation ?? defaultCenter,
              zoom: 14,
            ),
            markers: state.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onCameraMove: (position) => onAction(GoogleMapAction.onCameraMove(position)),
            onCameraIdle: () => onAction(const GoogleMapAction.onCameraIdle()),
          ),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator()),
          if (state.error != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.redAccent,
                child: Text(
                  '에러: ${state.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          if (state.noResult)
            Positioned(
              bottom: 100, // 기존 top: 20 → bottom으로 이동
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '화장실 정보가 없습니다',
                  style: TextStyle(color: Colors.white, fontSize: 14), // 폰트 줄임
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}