import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';

class SearchCardWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final String? subtitle;
  final Color foregroundColor;
  final IconData icon;
  final Color color;
  const SearchCardWidget({
    super.key,
    required this.child,
    required this.title,
    required this.icon,
    required this.color,
    required this.foregroundColor,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: CustomTheme.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: color,
                  foregroundColor: foregroundColor,
                  child: Icon(
                    icon,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
            child,
          ],
        ),
      ),
    );
  }
}
