import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class CustomTheme {
  static Color primaryColor = const Color.fromARGB(255, 255, 17, 0);
  static Color secondaryColor = const Color.fromRGBO(73, 89, 99, 1);

  static Color blackColor = const Color.fromRGBO(32, 32, 45, 1);
  static Color borderColor = const Color.fromRGBO(204, 204, 204, 1);
  static Color redColor = const Color.fromRGBO(244, 63, 94, 1);
  static Color backgroundColor = Colors.white;
  // static Color backgroundColor = const Color.fromRGBO(245, 245, 245, 1);
  // static Color backgroundColor = const Color.fromRGBO(242, 242, 247, 1);

  static Color textColor = Colors.black;
  static Color textColorSecondary = const Color.fromRGBO(87, 87, 88, 1);

  static Color darkBackgroundColor = Colors.black;
  static Color darkTextColor = Colors.white;
  static Color darkTextColorSecondary = Colors.white.withOpacity(.7);

  static ButtonStyle grayButton = ElevatedButton.styleFrom(
    backgroundColor: textColor,
  );

  static ButtonStyle coloredOutlinedButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(252, 248, 247, 1),
    side: BorderSide(
      width: 1,
      color: CustomTheme.primaryColor,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    foregroundColor: CustomTheme.primaryColor,
    textStyle: const TextStyle(
      fontFamily: "Inter",
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
  );

  static ButtonStyle dynamicButton(BuildContext context) =>
      context.isDarkMode() ? whiteButton : ElevatedButton.styleFrom();

  static ButtonStyle redButton = ElevatedButton.styleFrom(
    backgroundColor: redColor,
  );

  static ButtonStyle whiteButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: textColor,
  );

  static ButtonStyle instagramButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(225, 48, 108, 1),
    foregroundColor: textColor,
  );

  static ButtonStyle blackButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: blackColor,
    foregroundColor: Colors.white,
  );

  static ButtonStyle whiteTwoButton = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  );

  static InputDecoration inputDecorationSecondary(BuildContext context) {
    return const InputDecoration()
        .applyDefaults(themeData.inputDecorationTheme.copyWith(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      fillColor: context.isDarkMode()
          ? const Color.fromRGBO(28, 28, 30, 1)
          : Colors.white,
      hintStyle: themeData.inputDecorationTheme.hintStyle!.copyWith(
        color: context.isDarkMode()
            ? const Color.fromRGBO(150, 150, 157, 1)
            : const Color.fromRGBO(101, 101, 105, 1),
        fontSize: 15,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(.2),
          width: .4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: CustomTheme.redColor.withOpacity(.5),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: CustomTheme.redColor.withOpacity(.7),
          width: 2,
        ),
      ),
    ));
  }

  static EdgeInsets screenPadding = const EdgeInsets.all(16);

  static final ThemeData themeData = ThemeData(
    fontFamily: "Avenir",

    primarySwatch: const MaterialColor(4278235570, {
      50: Color(0xffe5ffff),
      100: Color(0xffccffff),
      200: Color(0xff99feff),
      300: Color(0xff66feff),
      400: Color(0xff33feff),
      500: Color(0xff00feff),
      600: Color(0xff00cbcc),
      700: Color(0xff009899),
      800: Color(0xff006566),
      900: Color(0xff003333)
    }),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    primaryColorLight: const Color(0xffccffff),
    //primaryColorDark: const Color(0xff009899),
    scaffoldBackgroundColor: backgroundColor,
    cardColor: const Color(0xffffffff),
    dividerTheme: const DividerThemeData(
      color: Color.fromRGBO(217, 217, 217, .5),
    ),
    dividerColor: const Color.fromRGBO(217, 217, 217, .5),
    highlightColor: const Color(0x66bcbcbc),
    splashColor: const Color(0x66c8c8c8),
    unselectedWidgetColor: const Color(0x8a000000),
    disabledColor: const Color(0x61000000),
    secondaryHeaderColor: const Color(0xffe5ffff),
    dialogBackgroundColor: const Color(0xffffffff),
    indicatorColor: const Color(0xff00feff),
    hintColor: const Color(0x8a000000),
    // SnackBar
    snackBarTheme: snackBarThemeData(),
    // AppBar
    appBarTheme: appBarTheme(),
    // Card
    cardTheme: cardTheme(),
    // Button
    elevatedButtonTheme: elevatedButtonTheme(),
    // Text
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
  );

  static final ThemeData darkThemeData = ThemeData(
    fontFamily: "PlusJakartaSans",
    primarySwatch: const MaterialColor(4278235570, {
      50: Color(0xffe5ffff),
      100: Color(0xffccffff),
      200: Color(0xff99feff),
      300: Color(0xff66feff),
      400: Color(0xff33feff),
      500: Color(0xff00feff),
      600: Color(0xff00cbcc),
      700: Color(0xff009899),
      800: Color(0xff006566),
      900: Color(0xff003333)
    }),
    brightness: Brightness.dark,
    primaryColor: darkBackgroundColor,
    primaryColorLight: textColor,
    //primaryColorDark: const Color(0xff009899),
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: CupertinoColors.extraLightBackgroundGray,
    dividerTheme: DividerThemeData(color: textColor.withOpacity(.5)),
    dividerColor: textColor.withOpacity(.5),
    highlightColor: const Color(0x66bcbcbc),
    splashColor: const Color(0x66c8c8c8),
    unselectedWidgetColor: const Color(0x8a000000),
    disabledColor: const Color(0x61000000),
    secondaryHeaderColor: const Color(0xffe5ffff),
    dialogBackgroundColor: const Color(0xffffffff),
    indicatorColor: const Color(0xff00feff),
    hintColor: const Color(0x8a000000),
    // SnackBar
    snackBarTheme: snackBarThemeData(),
    // AppBar
    appBarTheme: themeData.appBarTheme.copyWith(
      titleTextStyle: themeData.appBarTheme.titleTextStyle!.copyWith(
        color: darkTextColor,
      ),
      backgroundColor: darkBackgroundColor,
    ),

    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.red),
      side: WidgetStateBorderSide.resolveWith(
        (states) => const BorderSide(
          width: 1.0,
          color: Color.fromRGBO(179, 172, 172, 1),
        ),
      ),
    ),
    // Card
    cardTheme: themeData.cardTheme.copyWith(
      color: const Color.fromRGBO(28, 28, 30, 1),
    ),
    // Button
    elevatedButtonTheme: themeData.elevatedButtonTheme,
    // Text
    textTheme: themeData.textTheme.copyWith(
      titleLarge: themeData.textTheme.titleLarge!.copyWith(
        color: Colors.white,
      ),
      labelLarge: themeData.textTheme.labelLarge!.copyWith(
        color: darkTextColor,
      ),
      labelMedium: themeData.textTheme.labelMedium!.copyWith(
        color: darkTextColorSecondary,
      ),
      bodyLarge: themeData.textTheme.bodyMedium!.copyWith(
        color: darkTextColor,
      ),
      bodyMedium: themeData.textTheme.bodyMedium!.copyWith(
        color: darkTextColor,
      ),
      bodySmall: themeData.textTheme.bodySmall!.copyWith(
        color: darkTextColor.withOpacity(.7),
      ),
      titleMedium: themeData.textTheme.titleMedium!.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: themeData.textTheme.titleSmall!.copyWith(
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
      fillColor: const Color.fromRGBO(28, 28, 30, 1),
      hintStyle: themeData.inputDecorationTheme.hintStyle!.copyWith(
        color: Colors.white.withOpacity(.6),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white.withOpacity(.2),
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.redColor.withOpacity(.5),
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.redColor.withOpacity(.7),
          width: 2,
        ),
      ),
    ),
  );

  static snackBarThemeData() {
    return SnackBarThemeData(
      backgroundColor: primaryColor,
    );
  }

  static inputDecorationTheme() {
    return InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 16,
      ),
      filled: true,
      fillColor: const Color.fromRGBO(237, 237, 237, .3),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.borderColor,
          width: 0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.borderColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.redColor,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomTheme.redColor,
          width: 2,
        ),
      ),
      hintStyle: TextStyle(
        fontSize: 13,
        fontFamily: "PlusJakartaSans",
        fontWeight: FontWeight.w500,
        color: CustomTheme.textColor.withOpacity(.5),
      ),
      prefixStyle: TextStyle(
        color: CustomTheme.textColor.withOpacity(.6),
        fontSize: 17,
      ),
      prefixIconColor: CustomTheme.textColor.withOpacity(.6),
      //hintText: "Yolculuk başlığı giriniz.",
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      titleLarge: const TextStyle(
        fontFamily: "avenir",
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 28,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontFamily: "avenir",
        color: textColor,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        letterSpacing: 0,
        // fontWeight: FontWeight.w700,
        // fontSize: 16,
      ),
      labelLarge: TextStyle(
        fontFamily: "avenir",
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: 17,
        letterSpacing: 0,
      ),
      labelMedium: TextStyle(
        fontFamily: "avenir",
        color: textColorSecondary,
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: 0,
      ),
      bodyMedium: TextStyle(
        fontFamily: "avenir",
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0,
      ),
      bodyLarge: TextStyle(
        fontFamily: "avenir",
        color: textColor.withOpacity(.9),
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 0,
      ),
      bodySmall: TextStyle(
        fontFamily: "avenir",
        fontSize: 15,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      ),
    );
  }

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(54),
        elevation: 0,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontFamily: "PublicaSans",
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static CardTheme cardTheme() {
    return CardTheme(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontFamily: "PlusJakartaSans",
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
