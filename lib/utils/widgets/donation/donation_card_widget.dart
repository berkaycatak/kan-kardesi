import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/screens/donation/detail/donation_detail_screen.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DonationCardWidget extends StatelessWidget {
  final bool? isDetail;
  final BloodRequestModel bloodRequest;
  const DonationCardWidget({
    super.key,
    this.isDetail,
    required this.bloodRequest,
  });

  @override
  Widget build(BuildContext context) {
    // PlatformTextButton'ın onPressed özelliğine null verildiğinde renkler değişir.
    // bu nedenle card ve buton ayrı duruyor.
    if (isDetail == true) {
      return cardBody(context);
    }

    return PlatformTextButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showBarModalBottomSheet(
          useRootNavigator: true,
          context: context,
          builder: (context) => DonationDetailScreen(
            bloodRequest: bloodRequest,
          ),
        );
      },
      child: cardBody(context),
    );
  }

  Card cardBody(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bağış İhtiyacı",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: CustomTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  Helpers.dateFormatter(
                    bloodRequest.createdAt!,
                  )!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            donationCardInfoWidget(
              context: context,
              icon: Icons.bloodtype,
              title: "Kan grubu",
              subtitle: bloodRequest.bloodType!.type!,
            ),
            const SizedBox(height: 6),
            if (isDetail == true) ...[
              const Divider(),
              const SizedBox(height: 6),
              donationCardInfoWidget(
                context: context,
                icon: Icons.person,
                title: "İlan sahibi",
                subtitle: bloodRequest.user!.name!,
              ),
              const SizedBox(height: 6),
              donationCardInfoWidget(
                context: context,
                icon: Icons.phone,
                title: "İletişim",
                subtitle: "+90 ${bloodRequest.user!.phone}",
                onPressed: () => call(),
              ),
              const SizedBox(height: 6),
              const Divider(),
              const SizedBox(height: 6),
            ],
            donationCardInfoWidget(
              context: context,
              icon: Icons.local_hospital,
              title: "Şehir",
              subtitle: bloodRequest.cityData!.name!,
            ),
            const SizedBox(height: 6),
            donationCardInfoWidget(
              context: context,
              icon: Icons.info,
              title: "Açıklama",
              subtitle: bloodRequest.description ?? "Açıklama eklenmemiş.",
            )
          ],
        ),
      ),
    );
  }

  Widget donationCardInfoWidget({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    Function()? onPressed,
  }) {
    return PlatformTextButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: CustomTheme.primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title:",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void call() {
    if (kDebugMode) {
      print("call");
    }
  }
}
