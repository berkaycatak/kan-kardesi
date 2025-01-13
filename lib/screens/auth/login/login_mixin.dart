import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

mixin LoginMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void login(BuildContext context) {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    formKey.currentState!.save();
    if (kDebugMode) {
      print(emailController.text);
      print(passwordController.text);
    }
  }
}
