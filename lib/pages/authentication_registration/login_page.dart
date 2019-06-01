import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mentor/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage;
  bool isLoading;

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
                FirebaseUser user = await AuthService().googleSignIn();
                errorMessage = null;
                isLoading = true;
                if (user != null) {
                  Navigator.pushNamed(context, '/home');
                } else {
                  errorMessage = "Please login to access the app.";
                }
                isLoading = false;
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
    isLoading = false;
    hasSeenOnBoarding();
  }

  void hasSeenOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('oboarding.hasSeen', true);
  }
}
