import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MainScreen'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(
        GoRouter.of(context)
            .routerDelegate
            .currentConfiguration
            .last
            .matchedLocation,
      );
    }
    return PopScope(
      canPop: false,
      child: PlatformScaffold(
        iosContentPadding: true,
        body: CupertinoTabScaffold(
          key: UniqueKey(),
          tabBar: CupertinoTabBar(
            activeColor:
                context.isDarkMode() ? Colors.white : CustomTheme.primaryColor,
            onTap: (int tappedIndex) async {
              if (navigationShell.currentIndex == tappedIndex) {
                String routePath = "";
                switch (tappedIndex) {
                  case 0:
                    routePath = RouterService.routes.home;
                    break;
                  case 1:
                    routePath = RouterService.routes.search;
                    break;
                  case 3:
                    routePath = RouterService.routes.profile;
                }

                RouterService.goNamed(
                  context: context,
                  route: routePath,
                );
              } else {
                navigationShell.goBranch(tappedIndex);
              }
            },
            currentIndex: navigationShell.currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: bottomBarIconWidget(
                  context: context,
                  icon: Icons.home,
                  index: 0,
                ),
                label: 'Anasayfa',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.yellow,
                icon: bottomBarIconWidget(
                  context: context,
                  icon: Icons.search,
                  index: 1,
                ),
                label: 'Ara',
              ),
              BottomNavigationBarItem(
                icon: bottomBarIconWidget(
                  context: context,
                  icon: Icons.account_circle,
                  index: 3,
                ),
                label: 'Profil',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (_) {
                return navigationShell;
              },
            );
          },
        ),
      ),
    );
  }

  Widget bottomBarIconWidget({
    required BuildContext context,
    required int index,
    required IconData icon,
  }) {
    return Icon(icon);
    // return svgIcon(
    //   icon: icon,
    //   height: 20,
    //   color: navigationShell.currentIndex == index
    //       ? selectedItemColor(context)
    //       : unselectedItemColor(context),
    // );
  }

  unselectedItemColor(BuildContext context) => context.isDarkMode()
      ? const Color.fromRGBO(110, 110, 110, 1)
      : const Color.fromRGBO(149, 149, 149, 1);

  selectedItemColor(BuildContext context) =>
      context.isDarkMode() ? Colors.white : CustomTheme.primaryColor;
}
