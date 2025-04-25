import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/google_map_screen/google_map_view_model.dart';
import 'google_map_action.dart';
import 'google_map_screen.dart';

class GoogleMapScreenRoot extends StatefulWidget {
  final GoogleMapViewModel googleMapViewModel;

  const GoogleMapScreenRoot({super.key, required this.googleMapViewModel});

  @override
  State<GoogleMapScreenRoot> createState() => _GoogleMapScreenRootState();
}

class _GoogleMapScreenRootState extends State<GoogleMapScreenRoot> {
  GoogleMapController? _controller;
  bool _controllerInitialized = false;

  @override
  void initState() {
    super.initState();
    widget.googleMapViewModel.initialize(const LatLng(37.498085, 127.0143833)).then((_) {
      final current = widget.googleMapViewModel.state.currentLocation;
      if (current != null && _controllerInitialized && _controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(current, 14));
      } else {
        print('⚠️ 초기 위치 이동 실패: 위치 또는 컨트롤러 없음');
      }
    });
  }

  void _handleAction(GoogleMapAction action) {
    if (action is OnMapCreated) {
      _controller = action.controller;
      _controllerInitialized = true;
      print('✅ GoogleMapController 저장됨');
    } else if (action is OnCurrentLocationTap) {
      final current = widget.googleMapViewModel.state.currentLocation;
      if (current != null && _controllerInitialized && _controller != null) {
        _controller!.animateCamera(CameraUpdate.newLatLng(current));
      } else {
        print('⚠️ 내 위치로 이동 실패: 위치 또는 컨트롤러 없음');
      }
    } else if (action is OnCameraMove) {
      widget.googleMapViewModel.setCenter(action.position.target);
    } else if (action is OnCameraIdle) {
      widget.googleMapViewModel.refreshToiletsAtCenter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.googleMapViewModel,
      builder: (context, _) {
        return GoogleMapScreen(
          state: widget.googleMapViewModel.state,
          onAction: _handleAction,
        );
      },
    );
  }
}
