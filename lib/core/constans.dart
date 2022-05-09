import 'package:dio/dio.dart';
import 'package:final_project/core/user_pref.dart';
import 'package:final_project/main.dart';

const String baseApiUrl = 'http://192.168.3.67:8000/api/'; //'http://server.yesilkalacak.com/api/';

const Map<String, dynamic> headers = {
  // "content-type": "application/json",
  // "host": "yesilkalacak.com"
  "accept": "application/json",
  "content-type": "application/json; charset=utf-8",
};

