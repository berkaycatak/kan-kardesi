// ignore_for_file: prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/services/firebase/notification_service.dart';

class FirebaseService extends BaseViewModel {
  NotificationService notificationService = NotificationService();
  String? fcmToken;

  Future<void> init(BuildContext context) async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    // await _notificationService.init();
    // fcmToken = await FirebaseMessaging.instance.getToken();
    // print(fcmToken);
  }

  String getFcmToken() {
    return fcmToken ?? "";
  }
}
