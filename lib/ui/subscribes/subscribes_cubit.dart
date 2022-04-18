import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/main.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SubscribesCubit extends Cubit<SubscribesState> {
  late Dio dio;
  List<Map> subscribe = [];
  String? title;
  LatLng? latLng;

  SubscribesCubit() : super(SubscribesState(loading: false)) {
    dio = Dio(BaseOptions(
      headers: {
        "host": "yesilkalacak.com",
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    ));
    dio.interceptors.add(LogInterceptor());
  }

  saveSubscribe() async {
    emit(SubscribesState(loading: true));
    try {
      var req = await dio.post(
          ("https://yesilkalacak.com/api/user/addSubscribe"),
          data: FormData.fromMap({
            "user_id": user?['id'],
            "title": title,
            "lat_lang":
                jsonEncode({"lat": latLng?.latitude, "lng": latLng?.longitude}),
          }));

      emit(SubscribesState(loading: false, success: req.statusCode == 200));
    } on DioError catch (e) {
      emit(SubscribesState(loading: false, error: e.message));
    } catch (e) {
      emit(SubscribesState(loading: false, error: e.toString()));
    }
  }

  getSubscribes() async {
    emit(SubscribesState(loading: true));
    try {
      var req = await dio.get("https://yesilkalacak.com/api/user/subscribes");

      emit(SubscribesState(loading: false, success: req.statusCode == 200));
    } on DioError catch (e) {
      emit(SubscribesState(loading: false, error: e.message));
    } catch (e) {
      emit(SubscribesState(loading: false, error: e.toString()));
    }
  }

  void changeTitle(String value) {
    title = value;
  }

  Set<Marker> getMarkers() {
    return {
      if (latLng != null) Marker(position: latLng!, markerId: MarkerId('f'))
    };
  }

  void onMapTap(LatLng value) {
    latLng = value;
    emit(SubscribesState(loading: false));
  }
}
