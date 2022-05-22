import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

mixin MappableCubit<State> on Cubit<State> {
  bool autoMoveToCurrentLocation = true;
  LatLng? target;
  LatLng? latLng;
  List<Marker> locations = [];
  List<Circle> circles = [];

  late GoogleMapController controller;

  Future initMappable() async {
    if (autoMoveToCurrentLocation) {
      try {
        final pos = await _determinePosition();

        target = LatLng(pos.latitude, pos.longitude);
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString() , toastLength:Toast.LENGTH_LONG );
      }
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Set<Marker> getMarkers() {
    return {
      ...locations,
      if (latLng != null) Marker(position: latLng!, markerId: MarkerId('f'))
    };
  }

  Set<Circle> getCircles() {
    return {
      ...circles,
    };
  }

  void onMapTap(LatLng value) {
    latLng = value;
    onRefresh();
  }

  Future<void> goToTheLake({LatLng? target}) async {
    final fTarget= target ?? LatLng(37.158333, 38.791668);
    circles = [
     // if(target !=null)
     // Circle(
     //   circleId: const CircleId('current'),
     //   center: target,
     //   radius: 100,
     //   fillColor: Colors.blue.shade400.withOpacity(0.9),
     //   strokeColor:  Colors.blue.shade100.withOpacity(0.1),
     // )
    ];
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: fTarget,

        zoom: 16.151926040649414)));


    onRefresh();
  }

 Future setMapController(GoogleMapController c) async {
    controller = c;
    moveToCurrent();
  }

  Future moveToCurrent()async{
    await initMappable();
    await goToTheLake(target: target);
  }

  onRefresh();
}
