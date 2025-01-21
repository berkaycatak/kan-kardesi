import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/widgets/donation/donation_card_widget.dart';

class DonationDetailScreen extends StatefulWidget {
  const DonationDetailScreen({super.key});

  @override
  State<DonationDetailScreen> createState() => _DonationDetailScreenState();
}

class _DonationDetailScreenState extends State<DonationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PlatformScaffold(
        backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
        iosContentPadding: true,
        appBar: customAppBar(
          context,
          title: "Bağış Detayı",
        ),
        body: Padding(
          padding: CustomTheme.screenPadding,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DonationCardWidget(isDetail: true),
            ],
          ),
        ),
      ),
    );
  }
}
