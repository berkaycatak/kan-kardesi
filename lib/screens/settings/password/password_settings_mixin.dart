// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:kan_kardesi/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

mixin PasswordSettingsMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  String? validatePassword(String? val) {
    String? message = Helpers.isEmpty(
      val,
      "Lütfen parolanızı tekrar girin",
    );

    if (message == null) {
      if (passwordController.text != rePasswordController.text) {
        return "Parolalarınız uyuşmuyor.";
      }
    } else {
      return message;
    }

    return null;
  }

  Future<void> updatePassword(BuildContext context) async {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    if (passwordController.text != rePasswordController.text) {
      Helpers.showAlertSnackBar(
        context,
        "Parolalarınız uyuşmuyor.",
      );
      return;
    }

    UserViewModel userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );

    bool status = await userViewModel.updatePassword(
      context,
      password: oldPasswordController.text,
      newPassword: passwordController.text,
      reNewPassword: rePasswordController.text,
    );

    if (status) {
      context.pop();
    }
    formKey.currentState!.save();
  }
}
