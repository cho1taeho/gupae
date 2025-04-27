import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/presentation/google_map_screen/google_map_view_model.dart';
import '../../core/utils/permission_utils.dart';
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
  bool _isLoading = true;
  LatLng? _initialLocation;

  @override
  void initState() {
    super.initState();
    _getMyLocationFirst();
  }

  Future<void> _getMyLocationFirst() async {
    try {
      final isGranted = await PermissionUtils.requestLocationPermission();
      if (!isGranted) {
        print('❌ 위치 권한 거부 - 앱 종료');
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pop();
        });
        return;

      }

      final myLocation = await widget.googleMapViewModel.getMyLocation();

      if (myLocation != null) {
        _initialLocation = myLocation;
        await widget.googleMapViewModel.initialize(myLocation);
      } else {
        print('⚠️ 현재 위치 가져오기 실패');
        _initialLocation = const LatLng(37.5665, 126.9780);
        await widget.googleMapViewModel.initialize(_initialLocation!);
      }
    } catch (e) {
      print('⚠️ 위치 초기화 실패: $e');
      _initialLocation = const LatLng(37.5665, 126.9780);
      await widget.googleMapViewModel.initialize(_initialLocation!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _moveToMyLocation() async {
    setState(() {
      _isLoading = true;
    });

    final myLocation = await widget.googleMapViewModel.getMyLocation();

    if (myLocation != null && _controllerInitialized && _controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLngZoom(myLocation, 14));
      widget.googleMapViewModel.setCenter(myLocation);
      widget.googleMapViewModel.refreshToiletsAtCenter();
    } else {
      print('⚠️ 내 위치로 이동 실패');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleAction(GoogleMapAction action) {
    if (action is OnMapCreated) {
      _controller = action.controller;
      _controllerInitialized = true;
      print('✅ GoogleMapController 저장됨');


      if (_initialLocation != null) {
        _controller!.animateCamera(CameraUpdate.newLatLngZoom(_initialLocation!, 14));
      }
    } else if (action is OnCurrentLocationTap) {
      _moveToMyLocation();
    } else if (action is OnCameraMove) {
      widget.googleMapViewModel.setCenter(action.position.target);
    } else if (action is OnCameraIdle) {
      widget.googleMapViewModel.refreshToiletsAtCenter();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('위치 정보를 가져오는 중...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

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