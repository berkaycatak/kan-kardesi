import 'package:flutter/material.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/utils/components/app/adaptive/adaptive_action.dart';

mixin ProfileMixin {
  void logout(BuildContext context) {
    // show logout dialog
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          actions: [
            adaptiveAction(
              context: context,
              onPressed: () {
                RouterService.goNamed(
                  context: context,
                  route: RouteConstants().welcome,
                );
              },
              child: const Text(
                "Çıkış Yap",
              ),
            ),
            adaptiveAction(
              context: context,
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Vazgeç",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
          title: const Text(
            "Çıkış Yap",
          ),
          content: const Text(
            "Çıkış yapmak istediğinize emin misiniz?",
          ),
        );
      },
    );
  }
}
