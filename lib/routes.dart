import 'package:flutter/material.dart';
import 'package:flutter_mentor/pages/home_page.dart';
import 'package:flutter_mentor/pages/onboarding_page.dart';

class ApplicationRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/onboarding': (BuildContext context) => OnBoardingPage(),
    '/home': (BuildContext context) => HomePage(),
  };
}
