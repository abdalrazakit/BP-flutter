import 'package:dio/dio.dart';
import 'package:final_project/core/user_pref.dart';

Interceptor tokenInterceptor =
    InterceptorsWrapper(onRequest: (options, handler) {
  options.headers.addAll({
    'Authorization': 'Bearer ${getToken()}',
  });

  return handler.next(options);
}, onResponse: (response, handler) {
  return handler.next(response);
}, onError: (DioError e, handler) {
  return handler.next(e);
});
