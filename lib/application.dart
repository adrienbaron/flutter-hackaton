import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/pages/authentication_registration/login_page.dart';
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
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
          accentColor: Colors.cyan[600],
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
    setState(() {
      homePage = hasSeenOnBoarding == null || hasSeenOnBoarding == false
          ? OnBoardingPage()
          : LoginPage();
    });
  }
}
