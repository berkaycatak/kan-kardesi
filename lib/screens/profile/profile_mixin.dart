// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/utils/components/app/adaptive/adaptive_action.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

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
                _logoutAction(context);
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

  Future<void> _logoutAction(BuildContext context) async {
    try {
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(
        context,
        listen: false,
      );
      await authViewModel.logout(context);

      RouterService.goNamed(
        context: context,
        route: RouterService.routes.welcome,
      );
    } catch (e) {
      Helpers.showAlertSnackBar(
        context,
        "Çıkış yaparken bir hata oluştu. Lütfen tekrar deneyin.",
      );
    }
  }
}
