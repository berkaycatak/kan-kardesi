// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/user/user_model.dart';
import 'package:kan_kardesi/repositories/user/user_repository.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/app/app_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends BaseViewModel {
  UserRepository userRepository = UserRepository();
  String? fcmToken;
  UserModel? userModel;

  Future<UserModel?> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      changeApiStatus(ResponseStatus.loading);

      String? fcmToken = GlobalVariables.playerID ?? "";

      Map payload = {
        "playerId": fcmToken,
        "email": email,
        "password": Helpers.stringToMd5(password),
      };

      userModel = await userRepository.login(
        context: context,
        payload: payload,
      );

      if (userModel != null) {
        GlobalVariables.userModel = userModel;
        await context
            .read<AppViewModel>()
            .setCurrentUser(peopleModel: userModel!);
      }

      changeApiStatus(ResponseStatus.successful);
      notifyListeners();

      return userModel;
    } catch (e) {
      changeApiStatus(ResponseStatus.successful);
      return null;
    }
  }

  Future<bool> register(
    BuildContext context, {
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required String passwordConfirmation,
    required BloodTypeModel bloodType,
  }) async {
    try {
      changeApiStatus(ResponseStatus.loading);

      String? fcmToken = GlobalVariables.playerID ?? "";

      Map payload = {
        "playerId": fcmToken,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": Helpers.stringToMd5(password),
        "blood_type": bloodType.id.toString(),
      };

      userModel = await userRepository.register(
        context: context,
        payload: payload,
      );

      if (userModel != null) {
        GlobalVariables.userModel = userModel;
        await context
            .read<AppViewModel>()
            .setCurrentUser(peopleModel: userModel!);
      }

      changeApiStatus(ResponseStatus.successful);
      notifyListeners();
      return userModel == null ? false : true;
    } catch (e) {
      changeApiStatus(ResponseStatus.successful);
      return false;
    }
  }

  Future<UserModel?> splash(BuildContext context) async {
    String? fcmToken = GlobalVariables.playerID ?? "";

    userModel = await userRepository.splash(
      context: context,
      token: fcmToken,
    );

    GlobalVariables.userModel = userModel;

    notifyListeners();
    return userModel;
  }

  Future<bool> logout(BuildContext context) async {
    UserRepository userRepository = UserRepository();

    bool status = await userRepository.logout(
      context: context,
    );

    GlobalVariables.userModel = null;
    userModel = null;
    return status;
  }
}
