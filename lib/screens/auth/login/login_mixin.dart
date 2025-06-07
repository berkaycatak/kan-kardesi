// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/user/user_model.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

mixin LoginMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  Future<void> login(BuildContext context) async {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    formKey.currentState!.save();
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    UserModel? userModel = await authViewModel.login(
      context,
      email: emailController.text,
      password: passwordController.text,
    );

    if (userModel == null) {
      return;
    }

    RouterService.goNamed(
      context: context,
      route: RouteConstants().home,
    );
  }
}
