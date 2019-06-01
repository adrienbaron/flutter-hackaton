import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';

class OnBoardingPage extends StatelessWidget {
  final pageList = [
    PageModel(
      color: const Color.fromARGB(200, 103, 143, 180),
      heroAssetPath: 'assets/images/student.png',
      title: Text(
        'Looking for a Mentor ?',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      body: Text(
        'Here you find the one for you.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'assets/images/cap.png',
    ),
    PageModel(
      color: const Color.fromARGB(200, 101, 176, 180),
      heroAssetPath: 'assets/images/teacher.png',
      title: Text(
        'Becoming a Mentor ?',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      body: Text(
        'You can offer your services here.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'assets/images/info.png',
    ),
    PageModel(
      color: const Color.fromARGB(200, 155, 144, 188),
      heroAssetPath: 'assets/images/path.png',
      title: Text(
        'My Path',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
      body: Text(
        'You can find the right path for you',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      iconAssetPath: 'assets/images/trophy.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
          image: new AssetImage("assets/images/login_background.jpg"),
          fit: BoxFit.cover,
        )),
        child: FancyOnBoarding(
          pageList: pageList,
          mainPageRoute: '/login',
        ),
      ),
    );
  }
}
