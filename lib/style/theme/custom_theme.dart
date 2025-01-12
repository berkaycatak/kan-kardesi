import 'package:flutter/material.dart';

class CustomTheme {
  static Color primaryColor = const Color.fromRGBO(236, 86, 68, 1);
  static Color secondaryColor = const Color.fromRGBO(73, 89, 99, 1);

  static Color blackColor = const Color.fromRGBO(32, 32, 45, 1);
  static Color borderColor = const Color.fromRGBO(204, 204, 204, 1);
  static Color redColor = const Color.fromRGBO(244, 63, 94, 1);
  static Color backgroundColor = Colors.white;

  static Color textColor = Colors.black;
  static Color textColorSecondary = const Color.fromRGBO(87, 87, 88, 1);

  static Color darkBackgroundColor = Colors.black;
  static Color darkTextColor = Colors.white;
  static Color darkTextColorSecondary = Colors.white.withOpacity(.7);

  static EdgeInsets screenPadding = const EdgeInsets.all(16);

  static final ThemeData themeData = ThemeData();

  static final ThemeData darkThemeData = ThemeData();
}
