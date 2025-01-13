import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:kan_kardesi/screens/auth/welcome/welcome_mixin.dart';
import 'package:kan_kardesi/style/theme/custom_theme.dart';
import 'package:kan_kardesi/utils/constants/image/image_constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with WelcomeMixin {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: CustomTheme.screenPadding.left,
            right: CustomTheme.screenPadding.right,
            bottom: CustomTheme.screenPadding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(ImageConstants.welcome),
              Column(
                children: [
                  Text(
                    "Bağışçı Ol!\nBağışçılara Ulaş!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Çevrende kan bağışına mı ihtiyaç var?\nBağışçıları gör, talebini paylaş ve insanlara ulaş!",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  PlatformElevatedButton(
                    onPressed: () => register(context),
                    child: const Text("Kayıt Ol"),
                  ),
                  PlatformTextButton(
                    onPressed: () => login(context),
                    child: const Text("Giriş Yap"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
