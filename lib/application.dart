import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/pages/authentication_registration/login_page.dart';
import 'package:flutter_mentor/pages/home_page.dart';
import 'package:flutter_mentor/pages/onboarding_page.dart';
import 'package:flutter_mentor/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  Widget homePage;

  @override
  Widget build(BuildContext context) {
    if (homePage == null) {
      return Container();
    }

    return MaterialApp(
        title: config.applicationName,
        debugShowCheckedModeBanner: false,

        ///
        /// Routes
        ///
        routes: ApplicationRoutes.routes,

        home: homePage,
        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default Font Family
          fontFamily: 'Montserrat',
        ));
  }

  @override
  void initState() {
    super.initState();

    choseHomePage();
  }

  void choseHomePage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasSeenOnBoarding = prefs.getBool('oboarding.hasSeen');
    homePage = hasSeenOnBoarding ? LoginPage() : OnBoardingPage();
  }
}
