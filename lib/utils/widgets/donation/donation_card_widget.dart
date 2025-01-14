import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';

class DonationCardWidget extends StatelessWidget {
  const DonationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformTextButton(
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Bağış İhtiyacı",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: CustomTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              donationCardInfoWidget(
                context: context,
                icon: Icons.bloodtype,
                title: "Kan grubu",
                subtitle: "A Rh+",
              ),
              const SizedBox(height: 6),
              donationCardInfoWidget(
                context: context,
                icon: Icons.local_hospital,
                title: "Şehir",
                subtitle: "İstanbul",
              ),
              const SizedBox(height: 6),
              donationCardInfoWidget(
                context: context,
                icon: Icons.info,
                title: "Açıklama",
                subtitle:
                    "Acil 2 ünite A Rh+ kana ihtiyaç var. Kızılay üzerinden bağış yapabilirsiniz.",
              )
            ],
          ),
        ),
      ),
    );
  }

  Row donationCardInfoWidget({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 28,
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
    );
  }
}
