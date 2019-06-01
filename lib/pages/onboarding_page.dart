import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';

class OnBoardingPage extends StatelessWidget {
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/images/mentor_mentee.png',
        title: Text('Looking for a Mentor ?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 20.0,
            )),
        body: Text('Here you find the one for you.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/mentor_mentee.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/images/profile.png',
        title: Text('Becoming a Mentor ?',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 20.0,
            )),
        body: Text('You can offer your services here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/mentor_mentee.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/images/learning.png',
      title: Text('My Path',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 20.0,
          )),
      body: Text('You can find the right path for you',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/images/learning.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '/login',
      ),
    );
  }
}
