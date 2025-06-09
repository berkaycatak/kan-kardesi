import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/firebase_options.dart';
import 'package:kan_kardesi/services/firebase/notification_service.dart';
import 'package:kan_kardesi/services/router/router_service.dart';
import 'package:kan_kardesi/style/theme/custom_cupertino_theme.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/view_models/app/app_view_model.dart';
import 'package:kan_kardesi/view_models/auth/auth_view_model.dart';
import 'package:kan_kardesi/view_models/donation/donation_view_model.dart';
import 'package:kan_kardesi/view_models/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService notificationService = NotificationService();
  notificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppViewModel()),
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => DonationViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    asyncInint();
    super.initState();
  }

  Future<void> asyncInint() async {
    var appProvider = Provider.of<AppViewModel>(context, listen: false);
    appProvider.observer = FirebaseAnalyticsObserver(
      analytics: appProvider.analytics,
    );

    await appProvider.analytics.setAnalyticsCollectionEnabled(true);
  }

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
