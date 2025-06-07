import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

PlatformTextButton inputSelector({
  required String title,
  bool? useDecoration = true,
  TextStyle? textStyle,
  required Future<void> Function() onPressed,
}) {
  return PlatformTextButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: useDecoration == true ? selectorDecoration() : null,
      child: Row(
        children: [
          Text(
            title,
            style: textStyle ??
                TextStyle(
                  color: Colors.black,
                  fontSize: Platform.isAndroid ? 14 : 16,
                  fontWeight: Platform.isAndroid ? FontWeight.w500 : null,
                ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black.withOpacity(.6),
          ),
        ],
      ),
    ),
  );
}

BoxDecoration selectorDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: const Color.fromRGBO(1, 1, 1, .1),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(4),
  );
}
