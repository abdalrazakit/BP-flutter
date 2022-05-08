import '../main.dart';

String? getToken() {
  return prefs.getString('token');
}

Future setToken(String value) async {
  await prefs.setString('token', value);
}

Future deleteToken( ) async {
  await prefs.remove('token');
}
