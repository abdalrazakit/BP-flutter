import 'package:final_project/ui/login_screen.dart';

import './ui/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/on_boarding_model.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

int _currentIndex = 0;

List<OnBoardingModel> pages = [];

void _addPages() {
  pages.add(
    OnBoardingModel(
      'Welcome!',
      'This application will help you protect the environment and people from fire',
      Icons.add_moderator_outlined,
      'assets/images/fire1.jpg',
    ),
  );
  pages.add(
    OnBoardingModel(
      'Select a location',
      'You can locate and report a fire on the map',
      Icons.add_location_alt_outlined,
      'assets/images/fire2.jpg',
    ),
  );
  pages.add(
    OnBoardingModel(
      'Add media',
      'You can send reports with photos or videos',
      Icons.add_a_photo_outlined,
      'assets/images/fire3.jpg',
    ),
  );
  pages.add(
    OnBoardingModel(
      'Notifications',
      "You can turn on notifications so you get notified when there's a fire near you",
      Icons.add_alert_outlined,
      'assets/images/fire4.jpg',
    ),
  );
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _addPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(pages[index].image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      pages[index].icon,
                      size: 100.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    pages[index].title,
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 48.0, right: 48.0, top: 24),
                    child: Text(
                      pages[index].description,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0, 140),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSmoothIndicator(
                        activeIndex: _currentIndex,
                        count: pages.length,
                        effect: const WormEffect(
                          activeDotColor: Colors.red,
                          dotWidth: 18,
                          dotHeight: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          _updateSeen();
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white, fontSize: 18, letterSpacing: 1.5),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
