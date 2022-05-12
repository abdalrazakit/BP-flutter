import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/main.dart';
import 'package:final_project/ui/new_report/new_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewReportCubit extends Cubit<NewReportState> {
  late Dio dio;
  String? image;
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
    dio.interceptors.add(LogInterceptor());
  }

  saveReport() async {
    emit(NewReportState(loading: true));
    try {
      var req = await dio.post(
          ("http://server.yesilkalacak.com/api/user/report"),
          data: FormData.fromMap({
            "user_id": user?['id'],
            "image": MultipartFile.fromFile(image!),
            "description": desc,
            "lat_lang":
                jsonEncode({"lat": latLng?.latitude, "lng": latLng?.longitude}),
          }));

      emit(NewReportState(loading: false, success: req.statusCode == 200));
    } on DioError catch (e) {
      emit(NewReportState(loading: false, error: e.message));
    } catch (e) {
      emit(NewReportState(loading: false, error: e.toString()));
    }
  }

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

  void changeImage(String? value) {
    image = value;
    emit(NewReportState(loading: false));
  }
}
