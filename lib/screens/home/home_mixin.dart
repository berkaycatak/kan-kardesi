import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kan_kardesi/view_models/home/home_view_model.dart';
import 'package:provider/provider.dart';

mixin HomeMixin {
  void init(BuildContext context) async {
    getHome(context);
  }

  Future<void> getHome(BuildContext context, {bool showLoader = true}) async {
    try {
      HomeViewModel homeViewModel = Provider.of<HomeViewModel>(
        context,
        listen: false,
      );

      await homeViewModel.getHome(context, showLoader: showLoader);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
