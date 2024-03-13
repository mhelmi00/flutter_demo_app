import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String themeMode = 'Light';
  bool isDark = false;

  void toggleThemeData() {
    isDark = !isDark;
    themeMode = isDark ? 'Dark' : 'Light';
    notifyListeners();
  }
}
