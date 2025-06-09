// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/repositories/blood/blood_repository.dart';
import 'package:kan_kardesi/repositories/user/user_repository.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/user/user_view_model.dart';
import 'package:provider/provider.dart';

class DonationViewModel extends BaseViewModel {
  BloodRepository bloodRepository = BloodRepository();
  List<BloodRequestModel> requests = [];

  ResponseStatus currentSearchStatus = ResponseStatus.successful;
  ResponseStatus currentShareStatus = ResponseStatus.successful;

  Future<void> changeSearchApiStatus(ResponseStatus responseStatus) async {
    currentSearchStatus = responseStatus;
    notifyListeners();
  }

  Future<void> changeShareApiStatus(ResponseStatus responseStatus) async {
    currentShareStatus = responseStatus;
    notifyListeners();
  }

  Future<List<BloodRequestModel>> search(
    BuildContext context, {
    required CityModel selectedSearchCity,
    required BloodTypeModel selectedBloodType,
  }) async {
    try {
      changeSearchApiStatus(ResponseStatus.loading);

      Map payload = {
        "city": selectedSearchCity.id.toString(),
        "blood_type": selectedBloodType.id.toString(),
      };

      requests = await bloodRepository.search(
        context: context,
        payload: payload,
      );

      changeSearchApiStatus(ResponseStatus.successful);
      notifyListeners();
      return requests;
    } catch (e) {
      changeSearchApiStatus(ResponseStatus.successful);
      return [];
    }
  }

  Future<BloodRequestModel?> share(
    BuildContext context, {
    required CityModel selectedSearchCity,
    required BloodTypeModel selectedBloodType,
    String? description,
    required String unitNeeded,
  }) async {
    try {
      changeShareApiStatus(ResponseStatus.loading);

      Map payload = {
        "city": selectedSearchCity.id.toString(),
        "required_blood_type_id": selectedBloodType.id.toString(),
        "units_needed": unitNeeded,
        "description": description,
      };

      BloodRequestModel? request = await bloodRepository.share(
        context: context,
        payload: payload,
      );

      UserViewModel userViewModel = Provider.of<UserViewModel>(
        context,
        listen: false,
      );

      await userViewModel.getProfile(
        context,
        id: GlobalVariables.userModel!.id!,
      );

      changeShareApiStatus(ResponseStatus.successful);
      notifyListeners();
      return request;
    } catch (e) {
      changeShareApiStatus(ResponseStatus.successful);
      return null;
    }
  }
}
