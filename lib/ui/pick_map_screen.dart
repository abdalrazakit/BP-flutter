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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<MappableCubit, dynamic>(
          bloc: widget.bloc,
          listener: _listener,
          builder: (BuildContext context, state) {
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  onTap: (d) {
                    widget.bloc.onMapTap(d);
                  },
                  mapToolbarEnabled: true,
                  markers: widget.bloc.getMarkers(),
                  initialCameraPosition: _kGooglePlex,
                  circles: widget.bloc.getCircles(),
                  gestureRecognizers: {Factory(() => EagerGestureRecognizer())},
                  onMapCreated: (GoogleMapController controller) {
                    widget.bloc.setMapController(controller);
                  },
                ),
               // Positioned(
               //   child: Center(
               //     child: Material(
               //       borderRadius: BorderRadius.circular(32),
               //       child: InkWell(
               //         onTap: (){
               //           widget.bloc.moveToCurrent();
               //         },
               //         child: Padding(
               //           padding: const EdgeInsets.all(16.0),
               //           child: Row(  mainAxisSize: MainAxisSize.min,
               //             children: [
               //               SizedBox(width: 8,) ,
//
               //               Text('Current'),
               //               SizedBox(width: 16,) ,
               //               Icon(Icons.location_searching) ,
               //               SizedBox(width: 8,) ,
//
               //             ],
               //           ),
               //         ),
               //       ),
               //     ),
               //   ),
               //   bottom: 16,
               //   left: 32,
               //   right: 32,
               // )
              ],
            );
          });
    });
  }

  void _listener(BuildContext context, state) {
    // if (widget.bloc.target != null) {
    //   _goToTheLake( target :widget.bloc.target);
    // }
  }
}
