// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/repositories/blood/blood_repository.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class DonationViewModel extends BaseViewModel {
  BloodRepository bloodRepository = BloodRepository();
  List<BloodRequestModel> requests = [];

  ResponseStatus currentSearchStatus = ResponseStatus.successful;

  Future<void> changeSearchApiStatus(ResponseStatus responseStatus) async {
    currentSearchStatus = responseStatus;
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
}
