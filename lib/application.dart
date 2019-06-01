import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/pages/authentication_registration/login_page.dart';
import 'package:flutter_mentor/pages/home_page.dart';
import 'package:flutter_mentor/routes.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: config.applicationName,
        debugShowCheckedModeBanner: false,

        ///
        /// Routes
        ///
        routes: ApplicationRoutes.routes,

//            home: OnBoardingPage(),
        home: LoginPage(),
        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default Font Family
          fontFamily: 'Montserrat',
        ));
  }
}
