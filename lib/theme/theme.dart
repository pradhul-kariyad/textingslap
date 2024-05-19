import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:textingslap/provider/themesProvider.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade400,
    primary: Colors.grey.shade300,
    secondary: Colors.grey.shade200,
  ),
);

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);

void toggleTheme(BuildContext context) {
  ThemesProvider themeProvider =
      Provider.of<ThemesProvider>(context, listen: false);
  if (themeProvider.getTheme() == lightMode) {
    themeProvider.setTheme(darkMode);
  } else {
    themeProvider.setTheme(lightMode);
  }
}
