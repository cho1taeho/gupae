import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gupae/core/provider/providers.dart';
import 'package:gupae/presentation/google_map_screen/google_map_view_model.dart';
import '../../core/utils/permission_utils.dart';
import 'google_map_action.dart';
import 'google_map_screen.dart';

class GoogleMapScreenRoot extends ConsumerStatefulWidget {
  const GoogleMapScreenRoot({Key? key}) : super(key: key);

  @override
  ConsumerState<GoogleMapScreenRoot> createState() => _GoogleMapScreenRootState();
}

class _GoogleMapScreenRootState extends ConsumerState<GoogleMapScreenRoot> {
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
      final viewModel = ref.read(googleMapViewModelProvider);
      final myLocation = await viewModel.getMyLocation();

      if (myLocation != null) {
        _initialLocation = myLocation;
        await viewModel.initialize(myLocation);
      } else {
        print('⚠️ 현재 위치 가져오기 실패');
        _initialLocation = const LatLng(37.5665, 126.9780);
        await viewModel.initialize(_initialLocation!);
      }
    } catch (e) {
      print('⚠️ 위치 초기화 실패: $e');
      _initialLocation = const LatLng(37.5665, 126.9780);
      await ref.read(googleMapViewModelProvider).initialize(_initialLocation!);
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
    final viewModel = ref.read(googleMapViewModelProvider);
    final myLocation = await viewModel.getMyLocation();

    if (myLocation != null && _controllerInitialized && _controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLngZoom(myLocation, 14));
      viewModel.setCenter(myLocation);
      viewModel.refreshToiletsAtCenter();
    } else {
      print('⚠️ 내 위치로 이동 실패');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _handleAction(GoogleMapAction action) {
    final viewModel = ref.read(googleMapViewModelProvider);
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
      viewModel.setCenter(action.position.target);
    } else if (action is OnCameraIdle) {
      viewModel.refreshToiletsAtCenter();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(googleMapViewModelProvider);
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
      listenable: viewModel,
      builder: (context, _) {
        return GoogleMapScreen(
          state: viewModel.state,
          onAction: _handleAction,
        );
      },
    );
  }
}