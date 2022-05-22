import 'package:dio/dio.dart';
import 'package:final_project/core/user_pref.dart';
import 'package:final_project/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constans.dart';

class LoginCubit extends Cubit<LoginState> {
  late Dio dio;

  LoginCubit() : super(LoginState(loading: false)) {
    dio = Dio(BaseOptions(headers: headers, baseUrl: baseApiUrl));
    dio.interceptors.add(LogInterceptor());
  }

  sendCode(String phone) async {
    emit(LoginState(loading: true));
    try {
      var s = await dio.post(("user/sendCode"), data: {"phone": phone});

      emit(LoginState(loading: false, login_success: false, code_sent: true));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 411) {
          emit(new LoginState(loading: false, login_error: "Wrong number"));
        }
      }
    }
  }

  login(String phone, String code, String fcm_token) async {
    // emit(LoginState(loading: true));
    try {
      var req = await dio.post("user/login",
          data: {"code": code, "phone": phone, 'fcm_token': fcm_token});
      token = req.data["data"]["token"];
      user = req.data["data"]["user"];

      setToken(token!);

      emit(LoginState(loading: false, login_success: true));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 411) {
          emit(new LoginState(loading: false, login_error: "password wrong"));
        }
      }
    }
    // var data = req.data;
    // data.
  }
}

class LoginState {
  bool loading = false;
  String? login_error;
  bool login_success;
  bool code_sent;

  LoginState({
    required this.loading,
    this.login_error,
    this.login_success = false,
    this.code_sent = false,
  });
}
