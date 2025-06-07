import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:kan_kardesi/core/base/view_model/base_view_model.dart';
import 'package:kan_kardesi/models/user/user_model.dart';

class AppViewModel extends BaseViewModel {
  int selectedBottomBarPage = 0;
  bool showRoadOnboard = true;

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver? observer;

  Future<void> setCurrentUser({
    required UserModel peopleModel,
  }) async {
    await analytics.setUserId(
      id: peopleModel.id.toString(),
    );
  }

  void setCurrentScreen({
    required String screenName,
    required String className,
    int? id,
  }) async {
    if (id != null) {
      screenName = "$screenName [$id]";
    }
    await analytics.logScreenView(
      screenName: screenName,
    );

    await analytics.logEvent(
      name: "screen_view",
      parameters: {"screenName": screenName},
    );

    await analytics.logEvent(
      name: "screen_view",
      parameters: {"screen_name": screenName},
    );

    await analytics.logEvent(
      name: "custom_screen_view",
      parameters: {"screen_name": screenName},
    );
  }
}
