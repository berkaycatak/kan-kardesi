// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/services/request/request_service.dart';

class BloodRepository {
  final RequestServices _requestServices = RequestServices();

  Future<List<BloodRequestModel>> search({
    required BuildContext context,
    required Map payload,
  }) async {
    try {
      dynamic response = await _requestServices.sendRequest(
        context: context,
        path: "blood/search",
        isToken: true,
        payload: payload,
      );

      if (response == null) return [];

      List<dynamic> requestsRespose = response["blood_requests"];
      List<BloodRequestModel> requests = [];

      for (dynamic request in requestsRespose) {
        requests.add(BloodRequestModel.fromJson(request));
      }

      return requests;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
