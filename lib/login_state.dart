import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  late Dio dio;

  LoginCubit() : super(LoginState(loading: false)) {
    dio = Dio(BaseOptions(headers: {
      // "content-type": "application/json",
      // "host": "yesilkalacak.com"
      "accept": "application/json",
      "content-type": "application/json; charset=utf-8",
    }));
    dio.interceptors.add(new LogInterceptor());
  }

  sendCode(String phone) async {
    emit(LoginState(loading: true));
    try {
      var s = await dio.post(("https://yesilkalacak.com/api/user/sendCode"),
          data: {"phone": phone});
      emit(LoginState(loading: false ));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 411) {
          emit(new LoginState(loading: false, login_error: "Wrong number"));
        }
      }
    }
  }

  login(String phone, String code) async {
    // emit(LoginState(loading: true));
    try {
      var req = await dio.post(("https://yesilkalacak.com/api/user/login"),
          data: {"code": code, "phone": phone});
      var token = req.data["data"]["token"];
      var user = req.data["data"]["user"];
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

  LoginState(
      {required this.loading, this.login_error, this.login_success = false});
}
