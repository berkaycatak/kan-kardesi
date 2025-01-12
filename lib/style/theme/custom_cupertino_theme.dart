import 'package:flutter/cupertino.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';

class CustomCupertinoTheme {
  static final CupertinoThemeData themeData = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CustomTheme.primaryColor,
    scaffoldBackgroundColor: CustomTheme.backgroundColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: CustomTheme.primaryColor,
      textStyle: TextStyle(
        color: CustomTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );

  static final CupertinoThemeData darkThemeData = CupertinoThemeData(
    primaryColor: CustomTheme.primaryColor,
    scaffoldBackgroundColor: CustomTheme.darkBackgroundColor,
    textTheme: CupertinoTextThemeData(
      primaryColor: CustomTheme.primaryColor,
      textStyle: TextStyle(
        color: CustomTheme.textColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
