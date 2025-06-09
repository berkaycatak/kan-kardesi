import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/models/blog/blog_model.dart';
import 'package:kan_kardesi/models/blood/blood_request_model.dart';
import 'package:kan_kardesi/screens/home/home_mixin.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/components/app/custom_appbar_widget.dart';
import 'package:kan_kardesi/utils/constants/global_variables/global_variables.dart';
import 'package:kan_kardesi/utils/enums/reponse_status_enums.dart';
import 'package:kan_kardesi/utils/widgets/blog/blog_widget.dart';
import 'package:kan_kardesi/utils/widgets/donation/donation_card_widget.dart';
import 'package:kan_kardesi/utils/widgets/requests/blood_requests_list_widget.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:kan_kardesi/view_models/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with HomeMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);

    return PlatformScaffold(
      iosContentBottomPadding: true,
      iosContentPadding: true,
      backgroundColor: const Color.fromRGBO(238, 238, 243, 1),
      appBar: customAppBar(
        context,
        title: "Kan Kardeşi",
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
      body: RefreshIndicator.adaptive(
        onRefresh: () => getHome(context, showLoader: false),
        child: homeViewModel.currentStatus == ResponseStatus.loading
            ? Center(child: CircularProgressIndicator.adaptive())
            : ListView(
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
                                subtitle:
                                    "Kan grubuna göre bağışçı araması yapın.",
                                icon: context.platformIcons.search,
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
                                backgroundColor: CustomTheme.secondaryColor,
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
                    child: BloodRequestsListWidget(
                      requests: homeViewModel.homeModel!.requests,
                      city: GlobalVariables.userModel!.city!,
                    ),
                  )
                ],
              ),
      ),
    );
  }

  SizedBox welcomeWidget(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);
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
                "Merhaba ${authViewModel.userModel!.name!},",
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
      onPressed: () {
        RouterService.goNamed(
          context: context,
          route: RouteConstants().search,
        );
      },
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
    HomeViewModel homeViewModel = Provider.of<HomeViewModel>(context);

    return CarouselSlider(
      options: CarouselOptions(
        height: 155.0,
        padEnds: true,
        enlargeFactor: .5,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
      items: homeViewModel.homeModel!.blogs.map((BlogModel blog) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: BlogWidget(blog: blog),
        );
      }).toList(),
    );
  }
}
