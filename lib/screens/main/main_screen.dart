import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/screens/home/home_screen.dart';
import 'package:kan_kardesi/screens/main/main_mixin.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/helpers/helpers.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with MainMixin {
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
          tabBar: CupertinoTabBar(
            activeColor:
                context.isDarkMode() ? Colors.white : CustomTheme.primaryColor,
            onTap: (int tappedIndex) async {
              if (widget.navigationShell.currentIndex == tappedIndex) {
                String routePath = "";
                switch (tappedIndex) {
                  case 0:
                    routePath = RouterService.routes.home;
                    break;
                  case 1:
                    routePath = RouterService.routes.search;
                    break;
                  case 2:
                    routePath = RouterService.routes.profile;
                    break;
                }

                RouterService.goNamed(
                  context: context,
                  route: routePath,
                );
              } else {
                widget.navigationShell.goBranch(tappedIndex);
              }
            },
            currentIndex: widget.navigationShell.currentIndex,
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
                  index: 2,
                ),
                label: 'Profil',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (_) {
                // Her sekme içeriği için farklı widget döndür
                return screens[widget.navigationShell.currentIndex];
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
  }

  unselectedItemColor(BuildContext context) => context.isDarkMode()
      ? const Color.fromRGBO(110, 110, 110, 1)
      : const Color.fromRGBO(149, 149, 149, 1);

  selectedItemColor(BuildContext context) =>
      context.isDarkMode() ? Colors.white : CustomTheme.primaryColor;
}
