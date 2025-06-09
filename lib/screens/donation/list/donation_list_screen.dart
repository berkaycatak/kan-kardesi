import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/widgets/requests/blood_requests_list_widget.dart';

class DonationListScreen extends StatefulWidget {
  final List<BloodRequestModel> requests;
  final CityModel city;
  const DonationListScreen({
    super.key,
    required this.requests,
    required this.city,
  });

  @override
  State<DonationListScreen> createState() => _DonationListScreenState();
}

class _DonationListScreenState extends State<DonationListScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(
        context,
        title: widget.city.name,
      ),
      body: ListView(
        padding: CustomTheme.screenPadding,
        children: [
          BloodRequestsListWidget(
            requests: widget.requests,
            city: widget.city,
            showTitle: false,
          ),
        ],
      ),
    );
  }
}
