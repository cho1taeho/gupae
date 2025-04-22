

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:http/http.dart';

import '../../core/di/di_set_up.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _mapController;
  LatLng _defaultCenter = const LatLng(36.5, 127.5);
  final LocationViewModel _viewModel = getIt<LocationViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchCurrentLocation();
    _viewModel.addListener(_onStateChanged);
  }
  void _onStateChanged() {
    final current = _viewModel.state.currentLocation;
    if (current != null && _mapController != null) {
      _mapController!.moveCamera(CameraUpdate.newLatLng(current));
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onStateChanged);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final state = _viewModel.state;

    return Scaffold(
      appBar: AppBar(title: const Text('내 주변 화장실')),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              final current = state.currentLocation;
              if (current != null) {
                _mapController!.moveCamera(CameraUpdate.newLatLng(current));
              }
            },
            initialCameraPosition: CameraPosition(
              target: state.currentLocation ?? _defaultCenter,
              zoom: 14,
            ),
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
