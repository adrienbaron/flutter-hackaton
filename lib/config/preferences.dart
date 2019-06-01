import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


const String _storageKey = "MyIncredibleDressing_";
const String _kDefaultLanguage = "en";

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Preferences preferences = Preferences();

class Preferences {
  /// ----------------------------------------------------------
  /// Generic routine to fetch a preference
  /// ----------------------------------------------------------
  Future<String> _getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_storageKey + name) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves a preference
  /// ----------------------------------------------------------
  Future<bool> _setApplicationSavedInformation(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(_storageKey + name, value);
  }

  /// ----------------------------------------------------------
  /// Method that returns the session token
  /// ----------------------------------------------------------
  getMobileToken() async {
    return _getApplicationSavedInformation('token');
  }

  /// ----------------------------------------------------------
  /// Method that saves the session token
  /// ----------------------------------------------------------
  setMobileToken(String token) async {
    return _setApplicationSavedInformation('token', token);
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }
  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred theme
  /// ----------------------------------------------------------
  getPreferredTheme() async {
    return _getApplicationSavedInformation('theme');
  }
  setPreferredTheme(String theme) async {
    return _setApplicationSavedInformation('theme', theme);
  }
  String get defaultLanguage => _kDefaultLanguage;

  /// ----------------------------------------------------------
  /// Method that sets/gets a disconnected flag.
  /// It is used for Facebook authentication
  /// Once the user disconnects, this flag is set.
  /// If the user has not yet connected, this flag is true
  /// ----------------------------------------------------------
  Future<bool> getDisconnected() async {
    var flag = await _getApplicationSavedInformation('disconnected');
    return (flag == '' || flag == '1');
  }

  setDisconnected(bool value) async {
    return _setApplicationSavedInformation('disconnected', value ? '1' : '0');
  }

  /// ----------------------------------------------------------
  /// Method that sets/gets the PepitesList / LooksList version
  /// number linked to a certain user profile
  /// ----------------------------------------------------------
  Future<String> getItemsListVersionNumber(int profileId, String itemType) async {
    return _getApplicationSavedInformation('${itemType}ListVersion_$profileId');
  }

  setItemsListVersionNumber(int profileId, String itemType, String version) async {
    return _setApplicationSavedInformation('${itemType}ListVersion_$profileId', version);
  }

  // ------------------ SINGLETON -----------------------
  static final Preferences _preferences = Preferences._internal();
  factory Preferences(){
    return _preferences;
  }
  Preferences._internal();
}