import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(context, title: 'Profil', canPop: false),
      body: ListView(
        padding: CustomTheme.screenPadding,
        children: [
          profileDetailWidget(context),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "İhtiyaç Duyurularım",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                    ),
              ),
              PlatformIconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  RouterService.goNamed(
                    context: context,
                    route: RouteConstants().search,
                  );
                },
                icon: Icon(
                  context.platformIcons.addCircledSolid,
                  color: Colors.red,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: CustomTheme.screenPadding,
              child: const Text(
                  "İhtiyaç duyurunuz bulunmuyor. Sağlıklı günler dileriz. ❤️"),
            ),
          )
        ],
      ),
    );
  }

  SizedBox profileDetailWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: CustomTheme.screenPadding,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Kerem Alan",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "+90 507 720 98 17",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              PlatformElevatedButton(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Düzenle",
                ),
                onPressed: () {
                  // navigate to edit profile screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
