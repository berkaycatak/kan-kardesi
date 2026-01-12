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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController unitController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CityModel? selectedCity;
  BloodTypeModel? selectedBloodType;

  CityModel? selectedCityShare;
  BloodTypeModel? selectedBloodTypeShare;

  void init(BuildContext context) {
    selectedCity = GlobalVariables.userModel!.city;
    selectedCityShare = GlobalVariables.userModel!.city;
    selectedBloodType = GlobalVariables.userModel!.bloodType;
    selectedBloodTypeShare = GlobalVariables.userModel!.bloodType;
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

  Future<void> share(BuildContext context) async {
    bool isValidated = formKey.currentState!.validate();
    if (!isValidated) {
      return;
    }

    DonationViewModel donationViewModel = Provider.of<DonationViewModel>(
      context,
      listen: false,
    );

    if (selectedCityShare == null) {
      Helpers.showAlertSnackBar(
        context,
        "Lütfen şehir seçimi yapın.",
      );
      return;
    }

    if (selectedBloodTypeShare == null) {
      Helpers.showAlertSnackBar(
        context,
        "Lütfen kan grubu seçimi yapın.",
      );
      return;
    }

    BloodRequestModel? request = await donationViewModel.share(
      context,
      selectedSearchCity: selectedCity!,
      selectedBloodType: selectedBloodType!,
      description: descriptionController.text,
      unitNeeded: unitController.text,
    );

    if (request == null) {
      Helpers.showAlertSnackBar(
        context,
        "Bağış ihtiyacı gönderilirken bir problem oluştu. Lütfen daha sonra tekrar deneyin.",
      );
      return;
    }

    Helpers.showSuccessSnackBar(
      context,
      "İhtiyaç duyurusu başarıyla gönderildi.",
    );

    unitController.text = "";
    descriptionController.text = "";

    RouterService.goNamed(
      context: context,
      route: RouterService.routes.profile,
    );
  }
}
