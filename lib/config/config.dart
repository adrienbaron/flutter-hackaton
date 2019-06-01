import 'dart:ui';

import 'package:flutter/material.dart';

class Config {
  ///
  /// Singleton 
  /// 
  static final Config _config = Config._internal();
  factory Config(){
    return _config;
  }
  Config._internal();

  // -------------------------------------------------------

  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));
  List<String> get supportedAuthenticationModes => authenticationModes;

  // -------------------------------------------------------
  final List<String> supportedLanguages = ['en','fr'];
  final String applicationName = 'Flutter Mentor';
  final List<String> authenticationModes = ['email', 'google', /* 'facebook'  'twitter'*/];

  ///
}

Config config = Config();
