import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/widgets/blog/blog_widget.dart';
import 'package:kan_kardesi/utils/widgets/donation/donation_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(
        context,
        title: "Anasayfa",
        canPop: false,
        actions: [
          PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              context.platformIcons.search,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              RouterService.goNamed(
                context: context,
                route: RouteConstants().search,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: CustomTheme.screenPadding.left,
              right: CustomTheme.screenPadding.right,
              top: CustomTheme.screenPadding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                welcomeWidget(context),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: searchWidget(
                        context: context,
                        title: "Bağışçı ara",
                        subtitle: "Kan grubuna göre bağışçı araması yapın.",
                        icon: Icons.search,
                        backgroundColor: CustomTheme.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: searchWidget(
                        context: context,
                        title: "İhtiyaç duyur",
                        subtitle: "Acil bağış ihtiyacınızı duyurun.",
                        icon: Icons.campaign,
                        backgroundColor: const Color.fromRGBO(89, 175, 196, 1),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const BlogCarouselWidget(),
          const SizedBox(height: 14),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.screenPadding.left,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "İhtiyaç Duyuruları",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 14),
                const DonationCardWidget(),
                const SizedBox(height: 14),
                const DonationCardWidget(),
                const SizedBox(height: 100),
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox welcomeWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: CustomTheme.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Merhaba Kerem,",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                "Sağlıklı günler dileriz!",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PlatformTextButton searchWidget(
      {required BuildContext context,
      required String title,
      required String subtitle,
      required IconData icon,
      required Color backgroundColor,
      required Color foregroundColor}) {
    return PlatformTextButton(
      onPressed: () {},
      padding: EdgeInsets.zero,
      child: Card(
        child: Padding(
          padding: CustomTheme.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor,
                    child: Icon(
                      icon,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogCarouselWidget extends StatelessWidget {
  const BlogCarouselWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 155.0,
        padEnds: true,
        enlargeFactor: .5,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: BlogWidget(),
        );
      }).toList(),
    );
  }
}
