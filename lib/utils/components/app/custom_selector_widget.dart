import 'package:flutter/material.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

Widget customSelectorItem({
  required BuildContext context,
  required String title,
  required Color color,
  Color? backgroundColor,
  required IconData icon,
  Widget? right,
  Widget? bottom,
  void Function()? onTap,
  void Function()? onTitleTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (context.isDarkMode()
                ? const Color.fromRGBO(28, 28, 30, 1)
                : Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTitleTap,
              child: SizedBox(
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    if (right != null) right,
                  ],
                ),
              ),
            ),
          ),
          if (bottom != null) bottom,
        ],
      ),
    ),
  );
}
