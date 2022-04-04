

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String? token;

Map<String, dynamic>? user;

class NewReportCubit extends Cubit<NewReportState> {
  late Dio dio;
  //String? image;
  String? desc;
  LatLng? latLng;

  NewReportCubit() : super(NewReportState(loading: false)) {
    dio = Dio(BaseOptions(
      headers: {
        // "host": "yesilkalacak.com"
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ));
    dio.interceptors.add(new LogInterceptor());
  }

  saveReport() async {
    emit(NewReportState(loading: true));
    try {
      var req = await dio.post(("https://yesilkalacak.com/api/user/report"),
          data: FormData.fromMap({
            "user_id": user?['id'],
            //"image": MultipartFile.fromFile(image!),
            "description": desc,
            "lat_lang": {"lat": latLng?.latitude, "lng": latLng?.longitude},
          }));

      emit(NewReportState(loading: false, success: req.statusCode == 200));

    } on DioError catch (e) {
      emit(NewReportState(loading: false, error: e.message));
    } catch (e) {
      emit(NewReportState(loading: false, error: e.toString()));
    }
  }

  // void changeImage(String? value) {
  //   image = value;
  //   emit(NewReportState(loading: false));
  // }

  void changeDesc(String value) {
    desc = value;
  }

  Set<Marker> getMarkers() {
    return {
      if (latLng != null) Marker(position: latLng!, markerId: MarkerId('f'))
    };
  }

  void onMapTap(LatLng value) {
    latLng = value;
    emit(NewReportState(loading: false));
  }
}

class NewReportState {
  bool loading = false;
  String? error;
  bool success;

  NewReportState({required this.loading, this.error, this.success = false});
}
