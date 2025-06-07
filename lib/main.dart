import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_cupertino_theme.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RouterService routerService = RouterService();

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: PlatformTheme(
        materialDarkTheme: CustomTheme.themeData,
        materialLightTheme: CustomTheme.themeData,
        cupertinoLightTheme: CustomCupertinoTheme.themeData,
        cupertinoDarkTheme: CustomCupertinoTheme.themeData,
        builder: (context) {
          return PlatformApp.router(
            locale: const Locale("tr", "TR"),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('tr', 'TR'),
            ],
            routerConfig: routerService.router,
            debugShowCheckedModeBanner: false,
            title: 'Kan Kardeşi',
          );
        },
      ),
    );
  }
}
