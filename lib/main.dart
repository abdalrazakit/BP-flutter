import 'package:final_project/core/user_pref.dart';
import 'package:final_project/ui/all_fires/all_fires_screen.dart';
import 'package:final_project/ui/login/login_screen.dart';
import 'package:final_project/ui/new_report/new_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/fcm.dart';
import 'onboarding.dart';

String? token;

Map<String, dynamic>? user;
late SharedPreferences prefs;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFcm();
  prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen') ?? false;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(Start(seen));
}

class Start extends StatelessWidget {
  final bool seen;

  const Start(this.seen, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yeşil kalacak",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.normal),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FCMLlistiner(
        child: Builder(
          builder: (context) {
            if (!seen) {
              return OnBoarding();
            } else {
              if (getToken() != null) {
                return AllFiresScreen();
              } else {
                return LoginScreen();
              }
            }
          },
        ),
      ),
    );
  }
}
