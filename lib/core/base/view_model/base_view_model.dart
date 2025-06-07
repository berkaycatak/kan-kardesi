import 'package:flutter/material.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';

class BaseViewModel with ChangeNotifier {
  ResponseStatus currentStatus = ResponseStatus.successful;
  double actionButtonSize = 700.0;
  Duration actionButtonDuration = const Duration(milliseconds: 200);

  Future<void> changeApiStatus(
    ResponseStatus responseStatus, {
    bool? noDuration,
  }) async {
    if (responseStatus == ResponseStatus.loading) {
      actionButtonSize = 50;
    } else {
      actionButtonSize = 700;
    }
    notifyListeners();

    if (noDuration == false) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    currentStatus = responseStatus;

    notifyListeners();
  }
}
