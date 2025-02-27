import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kan_kardesi/screens/auth/login/login_screen.dart';
import 'package:kan_kardesi/screens/auth/register/register_screen.dart';
import 'package:kan_kardesi/screens/auth/splash/splash_screen.dart';
import 'package:kan_kardesi/screens/auth/welcome/welcome_screen.dart';
import 'package:kan_kardesi/screens/home/home_screen.dart';
import 'package:kan_kardesi/screens/main/main_screen.dart';
import 'package:kan_kardesi/screens/profile/profile_screen.dart';
import 'package:kan_kardesi/screens/search/search_screen.dart';
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
            name: "/${routes.welcome}",
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
              StatefulShellRoute.indexedStack(
                builder: (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return MainScreen(
                    navigationShell: navigationShell,
                  );
                },
                branches: <StatefulShellBranch>[
                  StatefulShellBranch(
                    routes: <RouteBase>[
                      GoRoute(
                        name: routes.home,
                        path: routes.home,
                        builder: (BuildContext context, GoRouterState state) {
                          return const HomeScreen();
                        },
                      )
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
