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
  final int? moveToFireById;

  late Dio dio;
  List<Map> reports = [];

  AllFiresCubit({this.moveToFireById}) : super(AllFiresState(loading: false)) {
    dio = Dio(BaseOptions(headers: headers, baseUrl: baseApiUrl));
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(tokenInterceptor);
  }

  getSubscribes() async {
    emit(AllFiresState(loading: true));
    try {
      var req = await dio.get("user/getActiveFires");

      reports = (req.data['data'] as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      try {
        final sLocations = reports.map((sub) {
          final _e = _latLngFromReport(sub);
          final _den_degree = sub['den_degree'];

          final _marker = Marker(
            infoWindow: InfoWindow(title: _getDegreeLabel(_den_degree.toString())),
            position: _e,
            visible: true,
            markerId: MarkerId(_e.toJson().toString()),
          );

          return _marker;
        }).toList();
        locations = sLocations;
      } catch (e) {
        print(e);
      }

      if (moveToFireById != null) {
        final fire = reports.firstWhere((e) => e['id'] == moveToFireById);
        target = _latLngFromReport(fire);
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

  LatLng _latLngFromReport(Map report) {
    return LatLng(double.parse(report['lat_lang']['lat'].toString()),
        double.parse(report['lat_lang']['lng'].toString()));
  }

  String _getDegreeLabel(String degree) {
    switch (degree) {
      case '1':
        return "Fake";

      case '2':
        return "Low";
      case '3':
        return "Normal";
      case '4':
        return "High";
      case '5':
        return "dangerous";
      default:
        return "No Degree";
    }
  }
}
