

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:http/http.dart';

import '../../core/di/di_set_up.dart';
import 'google_map_state.dart';

class GoogleMapScreen extends StatelessWidget {
  final GoogleMapState state;
  final Function(GoogleMapController) onMapCreated;
  final VoidCallback onCurrentLocationTap;

  const GoogleMapScreen({super.key, required this.state, required this.onMapCreated, required this.onCurrentLocationTap});


  @override
  Widget build(BuildContext context) {
    LatLng _defaultCenter = const LatLng(36.5, 127.5);
    return Scaffold(
      appBar: AppBar(title: const Text('내 주변 화장실')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: state.currentLocation ?? _defaultCenter,
              zoom: 14,
            ),
            markers: state.markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
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
        ],
      ),
    );
  }
}
