import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  late Dio dio;

  LoginCubit() : super(LoginState(loading: false)) {
    dio = Dio(BaseOptions(headers: {
      "content-type": "application/json",
      "host": "yesilkalacak.com"
    }));
    dio.interceptors.add(new LogInterceptor());
  }

  sendCode(String phone) async {
    emit(LoginState(loading: true));
    var s = "https://yesilkalacak.com/api/user/sendCode?phone=" + phone;
    var req = await dio.post((s));
    emit(LoginState(loading: false));
    // var data = req.data;
    // data.
  }

  login(String phone, String code) async {
    emit(LoginState(loading: true));
    var req = await dio.post(("https://yesilkalacak.com/api/user/login?phone=" +
        phone +
        "&code=" +
        code));

    emit(LoginState(loading: false));
    // var data = req.data;
    // data.
  }
}

class LoginState {
  bool loading = false;

  LoginState({required this.loading});
}
