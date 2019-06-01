import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';

class OnBoardingPage extends StatelessWidget {
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/images/about_us.jpg',
        title: Text('Onboarding',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Compolete your registration here',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/login.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/images/home.png',
        title: Text('login',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'We carefully verify all banks before adding them into the app',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/learning.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/images/home.png',
      title: Text('Store',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('All local stores are categorized for your convenience',
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
      appBar: AppBar(title: Text('Onboarding')),
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '/login',
      ),
    );
  }
}
