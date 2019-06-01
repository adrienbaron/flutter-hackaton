import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/config.dart';
import 'package:flutter_mentor/pages/authentication_registration/login_page.dart';
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
    );
  }
}
