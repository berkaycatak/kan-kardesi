import 'package:flutter/material.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';

mixin LoginMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  void login(BuildContext context) {
    RouterService.goNamed(context: context, route: RouteConstants().home);
    // bool isValidated = formKey.currentState!.validate();
    // if (!isValidated) {
    //   return;
    // }

    // formKey.currentState!.save();
    // if (kDebugMode) {
    //   print(emailController.text);
    //   print(passwordController.text);
    // }
  }
}
