import 'package:final_project/onboarding.dart';
import 'package:final_project/ui/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool seen;
  // seen = prefs.getBool('seen')!;
  // Widget _screen;
  //
  // if (seen == null || seen == false) {
  //   _screen = OnBoarding();
  // } else {
  //   _screen = ReportScreen();
  // }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home:OnBoarding(),
    );
  }
}

// class Start extends StatelessWidget {
//   final Widget _screen;
//
//   Start(this._screen);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: this._screen,
//     );
//   }
// }
