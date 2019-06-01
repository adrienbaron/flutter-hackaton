import 'package:flutter/material.dart';
import 'package:flutter_mentor/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService service;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(title: Text("Authentication")),
        body: Container(
          child: Center(
            child: RaisedButton(
              child: Text('login'),
              onPressed: () {
                service.googleSignIn();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() async {
    super.initState();

    service = AuthService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('oboarding.hasSeen', true);
  }
}
