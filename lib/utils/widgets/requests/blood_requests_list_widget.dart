import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/widgets/donation/donation_card_widget.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class BloodRequestsListWidget extends StatelessWidget {
  final List<BloodRequestModel> requests;
  final CityModel? city;
  final bool showTitle;
  final String? emptyText;
  const BloodRequestsListWidget({
    super.key,
    required this.requests,
    this.city,
    this.showTitle = true,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle && city != null) ...[
          Text(
            "İhtiyaç Duyuruları: ${city!.name!}",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20,
                ),
          ),
          const SizedBox(height: 14),
        ],
        if (requests.isEmpty)
          Card(
            child: Padding(
              padding: CustomTheme.screenPadding,
              child: Text(
                emptyText ??
                    "Harika haber, şehrinizde kan ihtiyacı bulunmuyor. 🫶",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                    ),
              ),
            ),
          )
        else
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: requests.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              BloodRequestModel bloodRequest = requests[index];
              return DonationCardWidget(
                bloodRequest: bloodRequest,
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 14),
          ),
        const SizedBox(height: 100),
      ],
    );
  }
}
