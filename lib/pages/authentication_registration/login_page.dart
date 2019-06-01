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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/login_background.jpg"),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: isLoading
                        ? CircularProgressIndicator(
                            value: null,
                            backgroundColor: Colors.black45,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          )
                        : Row(
                            children: <Widget>[
                              Padding(
                                child: Icon(Icons.person),
                                padding: EdgeInsets.only(right: 8.0),
                              ),
                              Text('Sign-in with Google'),
                            ],
                            mainAxisSize: MainAxisSize.min,
                          ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                              errorMessage = null;
                            });
                            FirebaseUser user =
                                await AuthService().googleSignIn();
                            if (user == null) {
                              setState(() {
                                errorMessage = "Please login to access the app.";
                              });
                            } else {
                              Navigator.pushNamed(context, '/home');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                    padding: EdgeInsets.all(12),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(errorMessage),
                    )
                ],
              ),
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
