import 'package:flutter/material.dart';
import 'package:flutter_mentor/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Text('Sign-in with Google'),
              onPressed: () async {
                await AuthService.googleSignIn();
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hasSeenOnBoarding();
  }

  void hasSeenOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('oboarding.hasSeen', true);
  }
}
