// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:toastification/toastification.dart';

class Helpers {
  static showAlertSnackBar(BuildContext context, String text) {
    showSnackBar(
      context: context,
      text: text,
      color: CustomTheme.redColor,
    );
  }

  static showSuccessSnackBar(BuildContext context, String text) {
    showSnackBar(
      context: context,
      text: text,
      color: CustomTheme.primaryColor,
    );
  }

  static showSnackBar({
    required BuildContext context,
    required String text,
    Color? color,
  }) {
    if (Platform.isIOS) {
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        description: Text(text),
        primaryColor: color,
        foregroundColor: context.isDarkMode() ? Colors.white : null,
        backgroundColor: color,
        alignment: Alignment.bottomCenter,
        autoCloseDuration: const Duration(seconds: 4),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
          closeIconColor: Colors.white,
          margin: const EdgeInsets.all(4),
          elevation: 0,
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: color,
          content: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String timeAgo(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} saniye önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} gün önce';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months ay önce';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years yıl önce';
    }
  }

  static dateFormatter(String date,
      {bool isShowHour = true,
      bool hiddenIsToday = false,
      bool showOnlyHourAndMinutes = false}) {
    if (date == "null") return;

    var dt = DateTime.parse(date);
    if (showOnlyHourAndMinutes) {
      return DateFormat("HH:mm", "TR_tr").format(dt);
    }

    if (hiddenIsToday) {
      if (dt.isToday) return DateFormat("HH:mm", "TR_tr").format(dt);
    }
    if (isShowHour) {
      return DateFormat("dd MMMM yyyy - HH:mm", "TR_tr").format(dt);
    } else {
      return DateFormat("dd MMMM yyyy", "TR_tr").format(dt);
    }
  }

  // static CustomIcons getDynamicIcon(String apiIconName) {
  //   apiIconName = apiIconName.replaceAll("-", "");
  //   CustomIcons? customIcon = CustomIcons.values.firstWhere(
  //     (icon) => icon.toString() == 'CustomIcons.$apiIconName',
  //     orElse: () => CustomIcons.category,
  //   );
  //   return customIcon;
  // }

  static String? isEmpty(val, message) {
    if (val == null || val.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  static String findAndReplaceKey({
    required String text,
    required String key,
    required String value,
  }) {
    return text.replaceAll("[[$key]]", value);
  }
}

extension CheckThemeMode on BuildContext {
  bool isDarkMode() => Theme.of(this).brightness == Brightness.dark;
  bool isLightMode() => Theme.of(this).brightness == Brightness.dark;
}

extension HexString on String {
  int getHexValue() => int.parse(replaceAll('#', '0xff'));
}

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}
