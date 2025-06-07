// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

mixin RegisterMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BloodTypeModel? selectedBloodType;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  var phoneFormatter = MaskTextInputFormatter(
    mask: '+## ### ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  String? phoneValidator(String? val) {
    String? validate = Helpers.isEmpty(
      val,
      "Lütfen telefon numarası girin",
    );
    if (validate == null) {
      if (val!.length <= 14 || val[1] != "9" || val[2] != "0") {
        return "Lütfen geçerli bir telefon numarası girin.";
      }
    }
    return null;
  }

  Future<void> register(BuildContext context) async {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    formKey.currentState!.save();
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(
      context,
      listen: false,
    );

    bool status = await authViewModel.register(
      context,
      name: nameController.text,
      phoneNumber: phoneNumberController.text.substring(
        4,
        phoneNumberController.text.length,
      ),
      email: emailController.text,
      password: passwordController.text,
      passwordConfirmation: rePasswordController.text,
      bloodType: selectedBloodType!,
    );

    if (status == false) {
      return;
    }

    RouterService.goNamed(
      context: context,
      route: RouteConstants().home,
    );
  }
}
