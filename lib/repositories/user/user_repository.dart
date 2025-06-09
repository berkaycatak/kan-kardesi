// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/user/user_model.dart';
import 'package:kan_kardesi/services/request/request_service.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/enums/shared_preferences_enums.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class UserRepository {
  final RequestServices _requestServices = RequestServices();
  String? authBarrier;

  Future<UserModel?> login({
    required BuildContext context,
    required Map payload,
  }) async {
    try {
      dynamic response = await _requestServices.sendRequest(
        context: context,
        path: "auth/login",
        isToken: false,
        payload: payload,
      );

      if (response == null) return null;

      UserModel people = UserModel.fromJson(response["user"]);

      const storage = FlutterSecureStorage();
      await storage.write(
        key: SharedPreferencesKeyEnums.token.name,
        value: response["token"],
      );

      return people;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<UserModel?> register({
    required BuildContext context,
    required Map payload,
  }) async {
    dynamic response = await _requestServices.sendRequest(
      context: context,
      path: "auth/register",
      isToken: false,
      payload: payload,
    );

    if (response == null) return null;

    UserModel people = UserModel.fromJson(response["user"]);

    const storage = FlutterSecureStorage();
    await storage.write(
      key: SharedPreferencesKeyEnums.token.name,
      value: response["token"],
    );

    return people;
  }

  Future<UserModel?> splash({
    required BuildContext context,
    String? token,
  }) async {
    var payload = {
      "playerId": token,
    };

    dynamic response = await _requestServices.sendRequest(
      path: "auth/splash",
      isToken: true,
      payload: payload,
      context: context,
    );

    if (response == null) return null;

    if (response["blood_types"] != null) {
      List<dynamic> bloodTypes = response["blood_types"];
      GlobalVariables.bloodTypes = bloodTypes
          .map((bloodType) => BloodTypeModel.fromJson(bloodType))
          .toList();
    } else {
      GlobalVariables.bloodTypes = [];
    }

    if (response["status"] == false) {
      return null;
    }

    UserModel people = UserModel.fromJson(response["user"]);

    const storage = FlutterSecureStorage();
    await storage.write(
      key: SharedPreferencesKeyEnums.token.name,
      value: response["token"],
    );

    return people;
  }

  Future<bool> logout({
    required BuildContext context,
  }) async {
    dynamic response = await _requestServices.sendRequest(
      context: context,
      path: "auth/logout",
      isToken: true,
      payload: {},
    );

    if (response == null) return false;

    const storage = FlutterSecureStorage();
    await storage.delete(key: SharedPreferencesKeyEnums.token.name);

    GlobalVariables.userModel = null;

    return true;
  }

  Future<UserModel?> updateProfile({
    required BuildContext context,
    required Map payload,
  }) async {
    dynamic response = await _requestServices.sendRequest(
      path: "settings/update",
      isToken: true,
      payload: payload,
      context: context,
    );

    if (response == null) return null;

    if (response["status"] == false) {
      return null;
    }

    if (response["user"] != null) {
      GlobalVariables.userModel = UserModel.fromJson(response["user"]);
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(
        context,
        listen: false,
      );
      authViewModel.setUserModel = GlobalVariables.userModel;
    }

    return GlobalVariables.userModel;
  }

  Future<UserModel?> updatePassword({
    required BuildContext context,
    required Map payload,
  }) async {
    dynamic response = await _requestServices.sendRequest(
      path: "settings/change-password",
      isToken: true,
      payload: payload,
      context: context,
    );

    if (response == null) return null;

    if (response["status"] == false) {
      return null;
    }

    if (response["user"] != null) {
      GlobalVariables.userModel = UserModel.fromJson(response["user"]);
      AuthViewModel authViewModel = Provider.of<AuthViewModel>(
        context,
        listen: false,
      );
      authViewModel.setUserModel = GlobalVariables.userModel;
    }

    return GlobalVariables.userModel;
  }
}
