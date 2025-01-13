import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';

PlatformAppBar customAppBar(
  BuildContext context, {
  final String? title,
  bool? canPop = true,
  List<Widget>? actions,
  final Color? backgroundColor,
  final Widget? leading,
  final List<Widget>? trailingActions,
  final bool? automaticallyImplyLeading,
  final PlatformBuilder<MaterialAppBarData>? material,
  final PlatformBuilder<CupertinoNavigationBarData>? cupertino,
}) {
  return PlatformAppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    material: material,
    cupertino: cupertino,
    backgroundColor: CustomTheme.primaryColor.withOpacity(.9),
    trailingActions: actions,
    leading: leading ??
        (canPop == null || canPop == true
            ? PlatformIconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  context.platformIcons.back,
                  size: 24,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null),
    title: title != null
        ? Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          )
        : const Text("Kan Kardeşi"),
  );
}
