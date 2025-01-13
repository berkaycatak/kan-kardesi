import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CupertinoColors.extraLightBackgroundGray,
      child: child,
    );
  }
}
