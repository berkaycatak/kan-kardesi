// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/models/user/user_model.dart';
import 'package:kan_kardesi/repositories/user/user_repository.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class UserViewModel extends BaseViewModel {
  UserRepository userRepository = UserRepository();
  String? fcmToken;

  Future<bool> updateProfile(
    BuildContext context, {
    required BloodTypeModel bloodType,
    required CityModel city,
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(
        context,
        listen: false,
      );

      changeApiStatus(ResponseStatus.loading);

      var payload = {
        "blood_type_id": bloodType.id.toString(),
        "city_id": city.id.toString(),
        "name": name,
        "email": email,
        "phone_number": phone.substring(4, phone.length),
      };

      UserModel? model = await userRepository.updateProfile(
        context: context,
        payload: payload,
      );

      if (authViewModel.userModel != null) {
        authViewModel.setUserModel = model;
        Helpers.showSuccessSnackBar(
          context,
          "Profil bilgileri başarıyla güncellendi.",
        );
      } else {
        Helpers.showAlertSnackBar(
          context,
          "Profil bilgileri güncellenemedi.",
        );
      }

      changeApiStatus(ResponseStatus.successful);
      notifyListeners();
      return authViewModel.userModel == null ? false : true;
    } catch (e) {
      changeApiStatus(ResponseStatus.successful);
      return false;
    }
  }

  Future<bool> updatePassword(
    BuildContext context, {
    required String password,
    required String newPassword,
    required String reNewPassword,
  }) async {
    try {
      changeApiStatus(ResponseStatus.loading);

      AuthViewModel authViewModel = Provider.of<AuthViewModel>(
        context,
        listen: false,
      );

      var payload = {
        "old_password": Helpers.stringToMd5(password),
        "new_password": Helpers.stringToMd5(newPassword),
      };

      UserModel? model = await userRepository.updatePassword(
        context: context,
        payload: payload,
      );

      if (model != null) {
        authViewModel.setUserModel = model;
        Helpers.showSuccessSnackBar(
          context,
          "Parola başarıyla güncellendi.",
        );
      } else {
        Helpers.showAlertSnackBar(
          context,
          "Parola güncellenirken bir problem oluştu.",
        );
      }

      changeApiStatus(ResponseStatus.successful);
      notifyListeners();
      return model == null ? false : true;
    } catch (e) {
      changeApiStatus(ResponseStatus.successful);
      return false;
    }
  }

  Future<bool> getProfile(
    BuildContext context, {
    required int id,
  }) async {
    try {
      changeApiStatus(ResponseStatus.loading);

      var payload = {
        "id": id.toString(),
      };

      UserModel? model = await userRepository.getProfile(
        context: context,
        payload: payload,
      );

      changeApiStatus(ResponseStatus.successful);
      notifyListeners();
      return model == null ? false : true;
    } catch (e) {
      changeApiStatus(ResponseStatus.successful);
      return false;
    }
  }
}
