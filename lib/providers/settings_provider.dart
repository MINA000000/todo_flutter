import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String lan = 'en';
  String mode = 'light';
  SharedPreferences? prefs;
  SettingsProvider() {
    init();
  }
  void init() async {
    prefs = await SharedPreferences.getInstance();
    lan = prefs!.getString('language') ?? 'en';
    mode = prefs!.getString('mode') ?? 'light';
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    lan = selectedLanguage;
    prefs!.setString('language', selectedLanguage);
    notifyListeners();
  }

  void changeMode(String selectedMode) {
    mode = selectedMode;
    prefs!.setString('mode', selectedMode);
    notifyListeners();
  }
}
