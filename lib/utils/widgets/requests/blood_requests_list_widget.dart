import 'package:flutter/material.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/models/location/city_model.dart';
import 'package:kan_kardesi/utils/widgets/donation/donation_card_widget.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class BloodRequestsListWidget extends StatelessWidget {
  final List<BloodRequestModel> requests;
  final CityModel city;
  const BloodRequestsListWidget({
    super.key,
    required this.requests,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "İhtiyaç Duyuruları: ${city.name!}",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
              ),
        ),
        const SizedBox(height: 14),
        if (requests.isEmpty)
          Text("Harika haber, şehrinizde kan ihtiyacı bulunmuyor. 🫶")
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
