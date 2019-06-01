import 'package:flutter/material.dart';
import 'package:flutter_mentor/application.dart';
import 'package:flutter_mentor/config/global_translations.dart';

void main() async {
  await allTranslations.init();
  
  runApp(Application());
}