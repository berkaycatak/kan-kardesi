import 'package:flutter/material.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';

mixin WelcomeMixin {
  void register(BuildContext context) {
    RouterService.goNamed(
        context: context, route: "/${RouteConstants().register}");
  }

  void login(BuildContext context) {
    RouterService.goNamed(
        context: context, route: "/${RouteConstants().login}");
  }
}
