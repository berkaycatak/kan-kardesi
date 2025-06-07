import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/screens/auth/login/login_screen.dart';
import 'package:kan_kardesi/screens/auth/register/register_screen.dart';
import 'package:kan_kardesi/screens/auth/splash/splash_screen.dart';
import 'package:kan_kardesi/screens/auth/welcome/welcome_screen.dart';
import 'package:kan_kardesi/screens/blog/detail/blog_detail_screen.dart';
import 'package:kan_kardesi/screens/home/home_screen.dart';
import 'package:kan_kardesi/screens/main/main_screen.dart';
import 'package:kan_kardesi/screens/profile/profile_screen.dart';
import 'package:kan_kardesi/screens/search/search_screen.dart';
import 'package:kan_kardesi/screens/settings/password/password_settings_screen.dart';
import 'package:kan_kardesi/screens/settings/profile/profile_settings_screen.dart';
import 'package:kan_kardesi/services/router/route_constants.dart';

class RouterService {
  static RouteConstants routes = RouteConstants();

  static void push(
      {required BuildContext context,
      required String route,
      Map<String, String>? parameter}) {
    GoRouter.of(context).push(
      "/$route",
      extra: parameter,
    );
  }

  static void goNamed({
    required BuildContext context,
    required String route,
    Map<String, String> pathParameters = const {},
    Object? extra,
  }) {
    context.goNamed(
      route,
      extra: extra,
      pathParameters: pathParameters,
    );
  }

  static Future<T?> pushNamed<T extends Object?>({
    required BuildContext context,
    required String route,
    Object? extra,
  }) async {
    return await context.pushNamed(route, extra: extra);
  }

  static void go({required BuildContext context, required String route}) {
    GoRouter.of(context).go("/$route");
  }

  static void pop({required BuildContext context}) {
    GoRouter.of(context).pop();
  }

  static void pushReplacementNamed(
      {required BuildContext context, required String route}) {
    GoRouter.of(context).pushReplacementNamed("/$route");
  }

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: routes.splash,
        path: routes.splash,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeIn).animate(animation),
                child: child,
              );
            },
          );
        },
        routes: <RouteBase>[
          GoRoute(
            name: routes.welcome,
            path: routes.welcome,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const WelcomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: CurveTween(curve: Curves.easeInOutCirc)
                        .animate(animation),
                    child: child,
                  );
                },
              );
            },
            routes: [
              GoRoute(
                name: "/${routes.register}",
                path: routes.register,
                builder: (BuildContext context, GoRouterState state) {
                  return const RegisterScreen();
                },
              ),
              GoRoute(
                name: "/${routes.login}",
                path: routes.login,
                builder: (BuildContext context, GoRouterState state) {
                  return const LoginScreen();
                },
              ),
            ],
          ),
          StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) {
              // return AnimatedSwitcher(
              //   duration: const Duration(milliseconds: 250),
              //   transitionBuilder: (child, animation) {
              //     // CurveTween'i burada tanımlıyoruz
              //     final curvedAnimation =
              //         CurveTween(curve: Curves.ease).animate(animation);
              //     return FadeTransition(
              //       opacity: curvedAnimation,
              //       child: child,
              //     );
              //   },
              //   child: MainScreen(
              //     navigationShell: navigationShell,
              //     // Benzersiz Key kullanarak her sekmeyi ayırıyoruz
              //     key: ValueKey<int>(navigationShell.currentIndex),
              //   ),
              // );
              return MainScreen(
                navigationShell: navigationShell,
                // Benzersiz Key kullanarak her sekmeyi ayırıyoruz
                key: ValueKey<int>(navigationShell.currentIndex),
              );
            },
            branches: <StatefulShellBranch>[
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: routes.home,
                    path: routes.home,
                    pageBuilder: (context, state) {
                      return CustomTransitionPage(
                        key: state.pageKey,
                        child: const HomeScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          // fastOutSlowIn eğrisini SlideTransition ile uygula
                          return FadeTransition(
                            opacity: CurveTween(curve: Curves.easeIn)
                                .animate(animation),
                            child: child,
                          );
                        },
                      );
                    },
                    routes: [
                      GoRoute(
                        name: routes.blog_detail,
                        path: routes.blog_detail,
                        builder: (BuildContext context, GoRouterState state) {
                          return const BlogDetailScreen();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: routes.search,
                    path: routes.search,
                    builder: (BuildContext context, GoRouterState state) {
                      return const SearchScreen();
                    },
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    name: routes.profile,
                    path: routes.profile,
                    builder: (BuildContext context, GoRouterState state) {
                      return const ProfileScreen();
                    },
                    routes: [
                      GoRoute(
                        name: routes.profile_settings,
                        path: routes.profile_settings,
                        builder: (BuildContext context, GoRouterState state) {
                          return const ProfileSettingsScreen();
                        },
                        routes: [
                          GoRoute(
                            name: routes.password_settings,
                            path: routes.password_settings,
                            builder:
                                (BuildContext context, GoRouterState state) {
                              return const PasswordSettingsScreen();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
