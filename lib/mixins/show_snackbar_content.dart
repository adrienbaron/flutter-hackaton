import 'package:flutter/material.dart';
import 'package:flutter_mentor/config/global_translations.dart';

class ShowSnackBarContentMixin {
  void showErrorMessageInSnackBar({
    GlobalKey<ScaffoldState> scaffoldKey,
    String errorMessage,
  }){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          allTranslations.text(errorMessage),
          textAlign: TextAlign.center,
        ),
      ));
    });
  }
}