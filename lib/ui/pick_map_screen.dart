import 'dart:async';

import 'package:final_project/ui/custom_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../new_report_cubit.dart';

class PickMapSample extends StatefulWidget {
  final NewReportCubit bloc ;

  const PickMapSample({Key? key,required this.bloc}) : super(key: key);
  @override
  State<PickMapSample> createState() => PickMapSampleState();
}

class PickMapSampleState extends State<PickMapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.158333, 38.791668),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.158333, 38.791668),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return   Builder(
      builder: (context) {
        return GoogleMap(
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            onTap:(d){widget.bloc.onMapTap(d);} ,
            mapToolbarEnabled: true,
            markers: widget. bloc.getMarkers(),
            initialCameraPosition: _kGooglePlex,
            gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
      }
    )  ;


  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
