import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

mixin RegisterMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  String? phoneValidator(val) {
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

  void register(BuildContext context) {
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
