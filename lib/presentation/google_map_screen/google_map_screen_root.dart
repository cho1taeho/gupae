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
  @override
  void initState() {
    super.initState();
    widget.googleMapViewModel.fetchMapData();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.googleMapViewModel,
      builder: (context, _) {
        return GoogleMapScreen(
          state: widget.googleMapViewModel.state,
          onMapCreated: (controller) {
            final current = widget.googleMapViewModel.state.currentLocation;
            if (current != null) {
              controller.moveCamera(CameraUpdate.newLatLng(current));
            }
          },
        );
      },
    );
  }
}
