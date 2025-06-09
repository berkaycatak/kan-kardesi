// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/home/home_model.dart';
import 'package:kan_kardesi/repositories/home/home_repository.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';

class HomeViewModel extends BaseViewModel {
  HomeRepository homeRepository = HomeRepository();
  HomeModel? homeModel = HomeModel(blogs: [], requests: []);

  Future<void> getHome(BuildContext context, {bool showLoader = true}) async {
    try {
      if (showLoader) changeApiStatus(ResponseStatus.loading);

      HomeModel? responseHomeModel = await homeRepository.getHome(
        context: context,
      );

      if (responseHomeModel != null) {
        homeModel = responseHomeModel;
      }

      if (showLoader) changeApiStatus(ResponseStatus.successful);
      notifyListeners();
    } catch (e) {
      if (showLoader) changeApiStatus(ResponseStatus.successful);
    }
  }
}
