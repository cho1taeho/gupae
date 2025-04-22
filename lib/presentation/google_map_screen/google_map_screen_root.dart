import 'package:flutter/material.dart';
import 'package:gupae/presentation/location/location_view_model.dart';
import 'package:gupae/presentation/subway_toilet/subway_toilet_view_model.dart';


class GoogleMapScreenRoot extends StatelessWidget {
  final LocationViewModel locationViewModel;
  final SubwayToiletViewModle subwayToiletViewModle;


  const GoogleMapScreenRoot({super.key, required this.subwayToiletViewModle, required this.locationViewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: subwayToiletViewModle,
      builder: (context, index) {

      }
    );
  }
}
