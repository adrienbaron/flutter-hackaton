import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:fancy_on_boarding/page_model.dart';

class OnBoardingPage extends StatelessWidget {
  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/hotels.png',
        title: Text('Hotels',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('All hotels and hostels are sorted by hospitality rating',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/key.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/banks.png',
        title: Text('Banks',
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
        iconAssetPath: 'assets/wallet.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/stores.png',
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
      iconAssetPath: 'assets/shopping_cart.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: FancyOnBoarding(
        pageList: pageList,
        mainPageRoute: '/home',
      ),
    );
  }
}
