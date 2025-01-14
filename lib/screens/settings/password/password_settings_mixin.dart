import 'package:flutter/material.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

mixin PasswordSettingsMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  String? validatePassword(val) {
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

  void updatePassword(BuildContext context) {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    if (passwordController.text != rePasswordController.text) {
      // Show error in textfield

      return;
    }
    formKey.currentState!.save();
    // Update password
  }
}
