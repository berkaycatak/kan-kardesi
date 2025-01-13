import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kan_kardesi/screens/auth/splash/splash_mixin.dart';
import 'package:kan_kardesi/utils/constants/image/svg_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin, SplashMixin {
  @override
  void initState() {
    init(this, context);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value,
              child: child,
            );
          },
          child: SizedBox(
            width: 100,
            child: SvgPicture.asset(
              SvgConstants.icon,
            ),
          ),
        ),
      ),
    );
  }
}
