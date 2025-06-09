import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:kan_kardesi/view_models/user/user_view_model.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

mixin ProfileSettingsMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BloodTypeModel? selectedBloodType;
  CityModel? selectedCity;
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
    } else {
      return validate;
    }
    return null;
  }

  void init() {
    nameController.text = GlobalVariables.userModel!.name!;
    phoneNumberController.text = "+90 ${GlobalVariables.userModel!.phone!}";
    emailController.text = GlobalVariables.userModel!.email!;
    selectedBloodType = GlobalVariables.userModel!.bloodType;
    selectedCity = GlobalVariables.userModel!.city;
  }

  Future<void> updateProfile(BuildContext context) async {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    formKey.currentState!.save();

    if (selectedCity == null) {
      Helpers.showAlertSnackBar(
        context,
        "Lütfen şehir seçimi yapın.",
      );
      return;
    }

    UserViewModel userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );

    await userViewModel.updateProfile(
      context,
      bloodType: selectedBloodType!,
      city: selectedCity!,
      name: nameController.text,
      phone: phoneNumberController.text,
      email: emailController.text,
    );
  }
}
