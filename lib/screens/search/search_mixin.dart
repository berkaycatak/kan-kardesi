// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/blood/blood_type_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:kan_kardesi/view_models/donation/donation_view_model.dart';
import 'package:provider/provider.dart';

mixin SearchMixin {
  CityModel? selectedCity;
  BloodTypeModel? selectedBloodType;

  void init(BuildContext context) {
    selectedCity = GlobalVariables.userModel!.city;
    selectedBloodType = GlobalVariables.userModel!.bloodType;
  }

  Future<void> search(BuildContext context) async {
    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(
      context,
      listen: false,
    );

    if (selectedCity == null) {
      Helpers.showAlertSnackBar(
        context,
        "Lütfen şehir seçimi yapın.",
      );
      return;
    }

    if (selectedBloodType == null) {
      Helpers.showAlertSnackBar(
        context,
        "Lütfen kan grubu seçimi yapın.",
      );
      return;
    }

    List<BloodRequestModel> requests = await donationViewModel.search(
      context,
      selectedSearchCity: selectedCity!,
      selectedBloodType: selectedBloodType!,
    );

    RouterService.goNamed(
      context: context,
      route: RouteConstants().search_list,
      extra: {
        "requests": requests,
        "city": selectedCity,
      },
    );
  }
}
