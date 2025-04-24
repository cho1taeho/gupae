import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/google_map_screen/google_map_view_model.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:gupae/presentation/subway_toilet/subway_toilet_view_model.dart';

import 'google_map_screen.dart';


class GoogleMapScreenRoot extends StatefulWidget {
  final GoogleMapViewModel googleMapViewModel;

  const GoogleMapScreenRoot({super.key, required this.googleMapViewModel, });

  @override
  State<GoogleMapScreenRoot> createState() => _GoogleMapScreenRootState();
}
class _GoogleMapScreenRootState extends State<GoogleMapScreenRoot> {
  GoogleMapController? _controller;
  bool _controllerInitialized = false;

  void _handleMapCreated(GoogleMapController controller) {
    _controller = controller;
    _controllerInitialized = true;
    print('✅ GoogleMapController 저장됨');

    widget.googleMapViewModel.fetchMapData().then((_) {
      final current = widget.googleMapViewModel.state.currentLocation;
      if (current != null) {
        print('📍 초기 위치 이동');
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(current, 14));
      } else {
        print('⚠️ 현재 위치 없음');
      }
    });
  }

  void _handleCurrentLocationTap() {
    final current = widget.googleMapViewModel.state.currentLocation;
    if (current != null && _controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLng(current));
    } else {
      print('⚠️ 내 위치로 이동 실패: 위치 또는 컨트롤러 없음');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.googleMapViewModel,
      builder: (context, _) {
        return GoogleMapScreen(
          state: widget.googleMapViewModel.state,
          onMapCreated: _handleMapCreated,
          onCurrentLocationTap: _handleCurrentLocationTap,
        );
      },
    );
  }
}
