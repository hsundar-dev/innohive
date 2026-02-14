import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData mytheme = ThemeData(
  fontFamily: 'Quicksand',
  primaryColor: Colors.green,
);

TextStyle listTitleDefaultTextStyle = const TextStyle(color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w600);

TextStyle listTitleSelectedTextStyle = const TextStyle(color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w600);


Color selectedColor = Colors.greenAccent;
Color drawerBackgroundColor = const Color.fromARGB(255, 76, 175, 80);

Color popupColor = Colors.white;


class AppGradients{
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromARGB(255, 33, 150, 243), // Light Blue
      Color.fromARGB(255, 76, 175, 80),],
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromARGB(255, 0, 56, 168), // Light Blue
      Color.fromARGB(255, 0, 77, 64)],
  );
}

class DarkModePreferences {
  static const String _isDarkModeKey = 'isDarkMode';

  // Getter to check if dark mode is enabled.
  static Future<bool> isDarkModeEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(_isDarkModeKey));
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  // Setter to toggle dark mode on/off.
  static Future<void> setDarkModeEnabled(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, value);
  }
}