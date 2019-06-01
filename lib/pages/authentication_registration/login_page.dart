import 'package:flutter/material.dart';
import 'package:flutter_mentor/widgets/selectors/language_selector.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Authentication"),
          actions: <Widget>[
            LanguageSelector(),
          ],
        ),
        body: Container(
          child: Center(
            child: RaisedButton(
              child: Text('login'),
              onPressed: (){},
            ),
          ),
        ),
      ),
    );
  }

  
}
