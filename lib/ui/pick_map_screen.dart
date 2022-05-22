import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'MappableCubit.dart';
import 'new_report/new_report_cubit.dart';

class PickMapSample extends StatefulWidget {
  final MappableCubit bloc;

  const PickMapSample({Key? key, required this.bloc}) : super(key: key);

  @override
  State<PickMapSample> createState() => PickMapSampleState();
}

class PickMapSampleState extends State<PickMapSample> {
  Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(37.158333, 38.791668),
      zoom: 14.4746,
    );

    _goToTheLake(target: widget.bloc.target);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<MappableCubit, dynamic>(
          bloc: widget.bloc,
          listener: _listener,
          builder: (BuildContext context, state) {
            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              onTap: (d) {
                widget.bloc.onMapTap(d);
              },
              mapToolbarEnabled: true,
              markers: widget.bloc.getMarkers(),
              initialCameraPosition: _kGooglePlex,
              gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          });
    });
  }

  Future<void> _goToTheLake({LatLng? target}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(

        target: target ?? LatLng(37.158333, 38.791668),
        tilt: 59.440717697143555,
        zoom: 16.151926040649414)));
  }

  void _listener(BuildContext context, state) {
    if (widget.bloc.target != null) {
      _goToTheLake( target :widget.bloc.target);
    }
  }
}
