import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/core/auth.dart';
import 'package:final_project/core/constans.dart';
import 'package:final_project/main.dart';
import 'package:final_project/ui/new_report/new_report_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../MappableCubit.dart';

class NewReportCubit extends Cubit<NewReportState> with MappableCubit {
  late Dio dio;
  String? image;
  String? desc;


  NewReportCubit() : super(NewReportState(loading: false)) {
    dio = Dio(BaseOptions(headers: headers, baseUrl: baseApiUrl));
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(tokenInterceptor);
  }

  saveReport() async {
    emit(NewReportState(loading: true));
    try {
      var req = await dio.post(("user/addUserReport"),
          data: FormData.fromMap({
            "image": await MultipartFile.fromFile(image!),
            "description": desc,
            "lat": latLng?.latitude,
            "lang": latLng?.longitude,
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



  void changeImage(String? value) {
    image = value;
    emit(NewReportState(loading: false));
  }

  void clear() {

    desc =null;
    latLng =null;
    image = null;
    emit(NewReportState(loading: false));
  }

  @override
  onRefresh() {
    emit(NewReportState(loading: false));
  }
}
