import 'package:flutter/material.dart';
import 'package:textingslap/theme/theme.dart';

class ThemesProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData getTheme() => _themeData;

  void setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
