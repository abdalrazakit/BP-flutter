import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/core/auth.dart';
import 'package:final_project/core/constans.dart';
import 'package:final_project/main.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../MappableCubit.dart';

class SubscribesCubit extends Cubit<SubscribesState> with MappableCubit {
  late Dio dio;
  List<Map> subscribes = [];
  String? description;

  SubscribesCubit() : super(SubscribesState(loading: false)) {
    dio = Dio(BaseOptions(headers: headers, baseUrl: baseApiUrl));
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(tokenInterceptor);
  }

  saveSubscribe() async {
    emit(SubscribesState(loading: true));
    try {
      var req = await dio.post("user/addUserSubscribe", data: {
        "description": description,
        "lat": latLng?.latitude,
        "lang": latLng?.longitude,
      });

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
      var req = await dio.get("user/getSubscribes");

      subscribes = (req.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      try {
        final sLocations = subscribes.map((sub) {
          final _e = LatLng(double.parse(sub['lat_lang']['lat'].toString()),
              double.parse(sub['lat_lang']['lang'].toString()));

          final _marker = Marker(
              position: _e,
              markerId: MarkerId(_e.toJson().toString()),
              infoWindow: InfoWindow(title: sub['description']));

          return _marker;
        }).toList();
        locations = sLocations;
      } catch (e) {
        print(e);
      }

      emit(SubscribesState(loading: false));
    } on DioError catch (e) {
      emit(SubscribesState(loading: false, error: e.message));
    } catch (e) {
      emit(SubscribesState(loading: false, error: e.toString()));
    }
  }

  void changeTitle(String value) {
    description = value;
  }

  @override
  onRefresh() {
    emit(SubscribesState(loading: false));
  }

  void clear() {
    description = null;

    latLng = null;

    emit(SubscribesState(loading: false));
  }

  Future<void> deleteSubscribe(int id) async {
    var req = await dio.delete("user/deleteUserSubscribe/$id");

    getSubscribes();
  }
}
