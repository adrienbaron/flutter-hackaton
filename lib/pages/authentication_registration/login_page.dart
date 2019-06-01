import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Authentication"),
          actions: <Widget>[],
        ),
        body: Container(
          child: Center(
            child: RaisedButton(
              child: Text('login'),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
