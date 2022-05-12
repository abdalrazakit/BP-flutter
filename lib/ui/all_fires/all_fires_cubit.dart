import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/core/auth.dart';
import 'package:final_project/core/constans.dart';
import 'package:final_project/main.dart';
import 'package:final_project/ui/subscribes/subscribes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../MappableCubit.dart';
import 'all_fires_state.dart';

class AllFiresCubit extends Cubit<AllFiresState> with MappableCubit {
  late Dio dio;
  List<Map> subscribes = [];

  AllFiresCubit() : super(AllFiresState(loading: false)) {
    dio = Dio(BaseOptions(headers: headers, baseUrl: baseApiUrl));
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(tokenInterceptor);
  }

  getSubscribes() async {
    emit(AllFiresState(loading: true));
    try {
      var req = await dio.get("user/getConfirmedReports");

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

          );

          return _marker;
        }).toList();
        locations = sLocations;
      } catch (e) {
        print(e);
      }

      emit(AllFiresState(loading: false));
    } on DioError catch (e) {
      emit(AllFiresState(loading: false, error: e.message));
    } catch (e) {
      emit(AllFiresState(loading: false, error: e.toString()));
    }
  }

  @override
  onRefresh() {
    emit(AllFiresState(loading: false));
  }
}
